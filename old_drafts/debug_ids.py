import pandas as pd
import os
import glob
import gzip

raw_dir = "data/raw/"

def find_file(pattern):
    files = sorted(glob.glob(os.path.join(raw_dir, f"*{pattern}*")))
    files = [f for f in files if os.path.isfile(f)]
    return files[0] if files else None

gse_ids = ["GSE285905", "GSE134533", "GSE293179", "GSE292944", "GSE304690", "GSE115828"]

print(f"{'Accession':<15} | {'Size':<10} | {'Status/IDs'}")
print("-" * 75)

for gse in gse_ids:
    f_path = find_file(gse)
    if not f_path:
        print(f"{gse:<15} | MISSING    | N/A")
        continue
    
    size_kb = os.path.getsize(f_path) / 1024
    
    try:
        sep = ',' if f_path.endswith('.csv.gz') else '\t'
        if 'tsv' in f_path: sep = '\t'
        
        if size_kb == 0:
            print(f"{gse:<15} | {size_kb:>7.1f} KB | ERROR: File is empty")
            continue

        df = pd.read_csv(f_path, sep=sep, index_col=0, nrows=3)
        print(f"{gse:<15} | {size_kb:>7.1f} KB | OK: {df.index.tolist()}")
            
    except Exception as e:
        try:
            with gzip.open(f_path, 'rt') as f:
                first_line = f.readline().strip()[:30]
            print(f"{gse:<15} | {size_kb:>7.1f} KB | PEEK: {first_line}")
        except:
            print(f"{gse:<15} | {size_kb:>7.1f} KB | CRITICAL ERROR")
