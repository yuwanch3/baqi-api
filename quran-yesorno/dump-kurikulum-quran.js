// Dump kurikulum QURAN L1-L5: level -> sublevel -> materi (title + jumlah soal + jenis) — read-only
const BASE = 'https://baqi.jannahku.com/react/';
const KEY = 'X64irOkE01qT0jWpG6re95j4MTHIa0Y5LiUK5Z3zFtPU7';
const toArr = (d) => (Array.isArray(d) ? d : (d && d.value && Array.isArray(d.value) ? d.value : []));
async function get(url) { try { const r = await fetch(url, { signal: AbortSignal.timeout(30000) }); return r.ok ? await r.json() : null; } catch (e) { return null; } }

(async () => {
  const levels = toArr(await get(BASE + 'level/' + KEY)).filter((lv) => String(lv.id).startsWith('LVC')).sort((a, b) => String(a.name).localeCompare(String(b.name), undefined, { numeric: true }));
  for (const lv of levels) {
    console.log(`\n===== ${lv.name} (${lv.id}) =====`);
    const subs = toArr(await get(BASE + 'sublevels/' + lv.name + '/' + KEY));
    for (const s of subs) {
      console.log(`  ◆ ${s.id} ${s.name}`);
      const mats = toArr(await get(BASE + 'materi/get/' + lv.name + '/' + s.name + '/' + KEY));
      for (const m of mats) {
        const qs = toArr(await get(BASE + 'questions/mid/' + m.id + '/' + KEY)).map((q) => ({ id: q.id, ...(q.value || {}) }));
        const types = {};
        for (const q of qs) types[q.type] = (types[q.type] || 0) + 1;
        const tStr = Object.entries(types).map(([k, v]) => `${k}:${v}`).join(' ') || '-';
        const title = String(m.information).split('\n')[0].trim().replace(/\s+/g, ' ').slice(0, 70);
        console.log(`    ${m.id} | ${title} | soal=${qs.length} (${tStr})`);
      }
    }
  }
})().catch((e) => console.error('ERR', e));