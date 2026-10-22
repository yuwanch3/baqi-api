const https = require('https');

const key = 'X64irOkE01qT0jWpG6re95j4MTHIa0Y5LiUK5Z3zFtPU7';
const BASE = 'https://baqi.jannahku.com/react/finex/';

function get(url) {
  return new Promise(resolve => {
    https.get(url, res => {
      let b = '';
      res.on('data', c => (b += c));
      res.on('end', () => resolve({ s: res.statusCode, b }));
    }).on('error', e => resolve({ s: 0, b: String(e) }));
  });
}

async function fetchSet(lid, exc) {
  const r = await get(BASE + lid + '/' + encodeURIComponent(exc) + '/' + key);
  if (!r.b) return { http: r.s, error: 'EMPTY BODY' };
  try {
    const j = JSON.parse(r.b);
    return { http: r.s, questions: j };
  } catch (e) {
    return { http: r.s, error: 'INVALID JSON: ' + r.b.slice(0, 80) };
  }
}

(async () => {
  for (let i = 1; i <= 12; i++) {
    const lid = 'PFC' + String(i).padStart(9, '0');
    for (const exc of ['Final Test', 'Inisialisasi', 'Final Advanced']) {
      const r = await fetchSet(lid, exc);
      if (r.error) { console.log(lid, exc, '=>', r.error); continue; }
      const qs = r.questions;
      const problems = [];
      qs.forEach((q, idx) => {
        const v = q.value;
        if (v.type === 'option' || v.type === 'multi') {
          if (!Array.isArray(v.options) || v.options.length === 0) problems.push(`#${idx + 1} ${q.id} options=${JSON.stringify(v.options)}`);
          else if (!v.options.includes(v.correct_option)) problems.push(`#${idx + 1} ${q.id} correct not in options`);
        }
        if (v.type === 'drag') {
          const nb = Array.isArray(v.correct_option) ? v.correct_option.length : -1;
          const no = Array.isArray(v.options) ? v.options.length : -1;
          problems.push(`drag#${idx + 1} ${q.id} blanks=${nb} opts=${no}${no === nb + 1 ? '' : '  <-- MISMATCH'}`);
        }
      });
      const bad = problems.filter(p => !p.includes('blanks=') || p.includes('MISMATCH'));
      console.log(lid, exc, 'n=' + qs.length, bad.length ? '\n   ' + bad.join('\n   ') : 'OK');
    }
  }
})();
