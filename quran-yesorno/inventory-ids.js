// Inventaris ID: max numeric SLV / MTR / QST di seluruh kurikulum — read-only
const BASE = 'https://baqi.jannahku.com/react/';
const KEY = 'X64irOkE01qT0jWpG6re95j4MTHIa0Y5LiUK5Z3zFtPU7';
const toArr = (d) => (Array.isArray(d) ? d : (d && d.value && Array.isArray(d.value) ? d.value : []));
async function get(url) { try { const r = await fetch(url, { signal: AbortSignal.timeout(30000) }); return r.ok ? await r.json() : null; } catch (e) { return null; } }
async function pump(items, size, fn) { const out = []; for (let i = 0; i < items.length; i += size) { const c = items.slice(i, i + size); out.push(...await Promise.all(c.map(fn))); } return out; }

(async () => {
  const levels = toArr(await get(BASE + 'level/' + KEY));
  let maxSLV = 0, maxMTR = 0, maxQST = 0, totalQ = 0;
  const slvAll = [];
  const mtrAll = [];
  for (const lv of levels) {
    const subs = toArr(await get(BASE + 'sublevels/' + lv.name + '/' + KEY));
    for (const s of subs) {
      const n = parseInt(String(s.id).replace(/^\D+/g, ''), 10);
      if (n > maxSLV) maxSLV = n;
      slvAll.push(`${s.id} ${s.level} ${s.name}`);
      const mats = toArr(await get(BASE + 'materi/get/' + lv.name + '/' + s.name + '/' + KEY));
      for (const m of mats) {
        const nm = parseInt(String(m.id).replace(/^\D+/g, ''), 10);
        if (nm > maxMTR) maxMTR = nm;
        mtrAll.push(`${m.id} ${lv.name} ${String(m.information).split('\n')[0].trim().slice(0, 40)}`);
        const qs = toArr(await get(BASE + 'questions/mid/' + m.id + '/' + KEY)).map((q) => ({ id: q.id, ...(q.value || {}) }));
        totalQ += qs.length;
        for (const q of qs) {
          const nq = parseInt(String(q.id).replace(/^\D+/g, ''), 10);
          if (nq > maxQST) maxQST = nq;
        }
      }
    }
  }
  console.log(`TOTAL SOAL: ${totalQ}`);
  console.log(`MAX SLV: ${maxSLV}`);
  console.log(`MAX MTR: ${maxMTR}`);
  console.log(`MAX QST: ${maxQST}`);
  // histogram 10-digit terakhir QST untuk cari blok kosong
  const hist = {};
  const all = [];
  for (const lv of levels) {
    const subs = toArr(await get(BASE + 'sublevels/' + lv.name + '/' + KEY));
    for (const s of subs) {
      const mats = toArr(await get(BASE + 'materi/get/' + lv.name + '/' + s.name + '/' + KEY));
      for (const m of mats) {
        const qs = toArr(await get(BASE + 'questions/mid/' + m.id + '/' + KEY)).map((q) => ({ id: q.id, ...(q.value || {}) }));
        for (const q of qs) { const nq = parseInt(String(q.id).replace(/^\D+/g, ''), 10); all.push(nq); hist[Math.floor(nq / 100)] = (hist[Math.floor(nq / 100)] || 0) + 1; }
      }
    }
  }
  console.log('\nBLOK QST (per 100): ' + Object.entries(hist).sort((a, b) => a[0] - b[0]).map(([k, v]) => `${k}00-${k}99:${v}`).join(' | '));
})().catch((e) => console.error('ERR', e));