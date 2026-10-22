const fs = require('fs');
const path = require('path');
const dir = path.join(__dirname, 'output');

/* PHP unserialize (subset) untuk verifikasi hasil serialize */
function phpUnserialize(input) {
  const buf = Buffer.from(input, 'utf8');
  let pos = 0;
  const matchAt = (re) => {
    const rest = buf.toString('utf8', pos);
    const m = re.exec(rest);
    if (!m) throw new Error('parse gagal di posisi ' + pos);
    pos += Buffer.byteLength(m[0], 'utf8');
    return m;
  };
  const readStr = (n) => {
    const s = buf.toString('utf8', pos, pos + n);
    pos += n;
    return s;
  };
  function read() {
    const t = String.fromCharCode(buf[pos]);
    if (t === 'a') {
      const m = matchAt(/^a:(\d+):\{/);
      const n = parseInt(m[1], 10);
      const out = [];
      for (let k = 0; k < n; k++) { matchAt(/^i:\d+;/); out.push(read()); }
      matchAt(/^\}/);
      return out;
    }
    if (t === 's') {
      const m = matchAt(/^s:(\d+):"/);
      const val = readStr(parseInt(m[1], 10));
      matchAt(/^";/);
      return val;
    }
    throw new Error('token tidak dikenal: ' + t);
  }
  const v = read();
  if (pos !== buf.length) throw new Error('sisa karakter di posisi ' + pos + ' dari ' + buf.length);
  return v;
}

function sqlUnescape(s) {
  return s.replace(/''/g, "'").replace(/\\\\/g, '\\');
}

/* Ambil semua nilai string ('...') dari baris SQL (semua kolom generator berupa string) */
function splitValues(line) {
  const marker = line.startsWith('INSERT') ? 'VALUES (' : ' SET ';
  let body = line.slice(line.indexOf(marker));
  const vals = [];
  let i = 0;
  while (i < body.length) {
    if (body[i] === "'") {
      let cur = '';
      i++;
      while (i < body.length) {
        if (body[i] === "'") {
          if (body[i + 1] === "'") { cur += "''"; i += 2; continue; }
          i++;
          break;
        }
        cur += body[i];
        i++;
      }
      vals.push(cur);
    } else {
      i++;
    }
  }
  return vals;
}

for (const f of ['update-3-sesi.sql', 'insert-semua-bab.sql']) {
  const p = path.join(dir, f);
  const txt = fs.readFileSync(p, 'utf8');
  const lines = txt.split(/\r?\n/).filter(l => l.startsWith('UPDATE') || l.startsWith('INSERT'));
  let bad = 0, checked = 0;
  for (const line of lines) {
    const v = splitValues(line).map(sqlUnescape);
    let opts, optsEn, corr, corrEn, type;
    if (line.startsWith('INSERT')) {
      // id,question,question_en,type,lid,excerpt,options,options_en,image,correct_option,correct_option_en,...
      type = v[3]; opts = v[6]; optsEn = v[7]; corr = v[9]; corrEn = v[10];
    } else {
      // SET question, question_en, type, lid, excerpt, options, options_en, correct_option, correct_option_en, updated
      type = v[2]; opts = v[5]; optsEn = v[6]; corr = v[7]; corrEn = v[8];
    }
    try {
      const o = phpUnserialize(opts);
      const oe = phpUnserialize(optsEn);
      if (!Array.isArray(o) || !Array.isArray(oe) || o.length !== oe.length) throw new Error('o/oe tidak sinkron');
      if (type === 'multi' || type === 'drag') {
        const c = phpUnserialize(corr);
        const ce = phpUnserialize(corrEn);
        if (!Array.isArray(c) || c.length !== ce.length) throw new Error('c/ce tidak sinkron');
        for (const x of c) if (!o.includes(x)) throw new Error('jawaban tidak ada di opsi: ' + x);
        if (type === 'drag' && o.length !== c.length + 1) throw new Error('drag opts=' + o.length + ' blanks=' + c.length);
      } else {
        if (!o.includes(corr)) throw new Error('jawaban tidak ada di opsi: ' + corr);
      }
      checked++;
    } catch (e) {
      bad++;
      if (bad <= 8) console.log('BAD:', f, e.message, '\n   ', line.slice(0, 160));
    }
  }
  console.log(`${f}: ${lines.length} baris, valid ${checked}, gagal ${bad}`);
}
