const fs = require('fs');
const path = require('path');

const dir = __dirname;
const sql = fs.readFileSync(path.join(dir, 'output', 'insert-semua-bab.sql'), 'utf8');
const lines = sql.split(/\r?\n/).filter(l => l.startsWith('INSERT'));

function rowFor(id) {
  return lines.find(l => l.includes("'" + id + "'"));
}

for (const id of process.argv.slice(2)) {
  const line = rowFor(id);
  if (!line) { console.log(id, 'NOT FOUND'); continue; }
  const na = [...line].filter(c => c.charCodeAt(0) > 126);
  const codes = [...new Set(na.map(c => 'U+' + c.charCodeAt(0).toString(16).toUpperCase().padStart(4, '0')))];
  console.log('===', id, 'len', line.length);
  console.log('non-ascii chars:', JSON.stringify(na.join('')), codes.join(','));
  console.log(line.slice(0, 900));
  console.log('');
}
