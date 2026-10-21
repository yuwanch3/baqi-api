#!/usr/bin/env python3
"""
Fix garbled characters in CEOR JSON files.
Issues found:
1. "A-" instead of "×" (multiplication sign)
2. "I�" / "AZA�" instead of "μ" (Greek mu)
3. Some options_en fields empty
"""

import json
import os

def fix_string(s):
    """Fix garbled characters in a string."""
    if not isinstance(s, str):
        return s
    # Fix specific patterns first (more specific first)
    s = s.replace('Sor - Soi', 'Sor × Soi')
    s = s.replace('Soi - Sor', 'Soi × Sor')
    s = s.replace('(Sor - Soi)', '(Sor × Soi)')
    s = s.replace('(Soi - Sor)', '(Soi × Sor)')
    # Fix A- in math contexts (e.g., "Sor A- Soi" -> "Sor × Soi")
    s = s.replace(' A- ', ' × ')
    s = s.replace('A- ', '× ')
    s = s.replace(' A-', ' ×')
    # Fix AZA� -> μ (corrupted mu character)
    s = s.replace('AZA�', 'μ')
    # Fix I� -> μ
    s = s.replace('I�', 'μ')
    # Fix any remaining A- patterns
    s = s.replace('A-', '×')
    return s

def fix_list(lst):
    """Fix garbled characters in a list of strings."""
    if not isinstance(lst, list):
        return lst
    return [fix_string(item) if isinstance(item, str) else item for item in lst]

def fix_file(filepath):
    with open(filepath, 'r', encoding='utf-8-sig') as f:
        data = json.load(f)
    
    fixed_count = 0
    for section in ['inisialisasi', 'advanced']:
        for q in data[section]:
            # Fix options (o)
            if 'o' in q and isinstance(q['o'], list):
                new_o = fix_list(q['o'])
                if new_o != q['o']:
                    q['o'] = new_o
                    fixed_count += 1
            
            # Fix options_en (oe)
            if 'oe' in q and isinstance(q['oe'], list):
                new_oe = fix_list(q['oe'])
                if new_oe != q['oe']:
                    q['oe'] = new_oe
                    fixed_count += 1
            
            # Fix correct_option (c) - could be string or array
            if 'c' in q:
                if isinstance(q['c'], str):
                    new_c = fix_string(q['c'])
                    if new_c != q['c']:
                        q['c'] = new_c
                        fixed_count += 1
                elif isinstance(q['c'], list):
                    new_c = fix_list(q['c'])
                    if new_c != q['c']:
                        q['c'] = new_c
                        fixed_count += 1
            
            # Fix correct_option_en (ce) - could be string or array
            if 'ce' in q:
                if isinstance(q['ce'], str):
                    new_ce = fix_string(q['ce'])
                    if new_ce != q['ce']:
                        q['ce'] = new_ce
                        fixed_count += 1
                elif isinstance(q['ce'], list):
                    new_ce = fix_list(q['ce'])
                    if new_ce != q['ce']:
                        q['ce'] = new_ce
                        fixed_count += 1
            
            # Ensure options_en is not empty - if empty, copy from options (ID) as fallback
            if 'oe' in q and 'o' in q:
                if not q['oe'] or len(q['oe']) == 0:
                    q['oe'] = q['o'].copy()
                    fixed_count += 1
            
            # Ensure correct_option_en is not empty
            if 'ce' in q and 'c' in q:
                if not q['ce'] or (isinstance(q['ce'], str) and q['ce'] == '') or (isinstance(q['ce'], list) and len(q['ce']) == 0):
                    q['ce'] = q['c']
                    fixed_count += 1
    
    if fixed_count > 0:
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        print(f"Fixed {filepath}: {fixed_count} changes")
    else:
        print(f"No changes needed: {filepath}")

# Process all CEOR files
ceor_files = [
    'bab-08-ceor.json',
    'bab-09-ceor.json', 
    'bab-10-ceor.json',
    'bab-11-ceor.json',
    'bab-12-ceor.json'
]

base_dir = r'C:\Users\User\baqi-opencode\sql\exam-3-sesi'
for fname in ceor_files:
    fix_file(os.path.join(base_dir, fname))

print("\nAll files processed.")