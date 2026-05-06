import pandas as pd
import mygene
import os
import glob

base_dir = os.path.expanduser("~/Epithelial_OxStress_Meta")
raw_dir = os.path.join(base_dir, "data/raw")
proc_dir = os.path.join(base_dir, "data/processed")
mg = mygene.MyGeneInfo()

if not os.path.exists(proc_dir):
    os.makedirs(proc_dir)

def clean_index(df):
    """Removes prefixes and version suffixes from Gene IDs"""
    idx = df.index.astype(str).str.replace(r'^gene:', '', regex=True)
    idx = idx.str.split('.').str[0].str.strip()
    return idx

def map_to_symbols(df, scope):
    """Maps IDs to HGNC Symbols and handles index alignment"""
    ids = df.index.tolist()
    results = mg.querymany(ids, scopes=scope, fields='symbol', species='human', verbose=False)
    mapping = {res['query']: res['symbol'] for res in results if 'symbol' in res}
    df.index = df.index.map(mapping)
    df = df[df.index.notnull()]
    return df.groupby(df.index).sum()

print("Processing Gut...")
gut_path = os.path.join(raw_dir, "GSE285905_Gut_counts.tsv.gz")
gut = pd.read_csv(gut_path, sep='\t', index_col=0)
gut.index = clean_index(gut)
gut = map_to_symbols(gut, 'ensembl.gene')

print("Processing Skin...")
skin_frames = []
for f in glob.glob(os.path.join(raw_dir, "skin_data/*.txt.gz")):
    tmp = pd.read_csv(f, sep='\t', index_col=1)
    s_name = os.path.basename(f).split('_')[0]
    skin_frames.append(tmp[['Count']].rename(columns={'Count': s_name}))
skin = pd.concat(skin_frames, axis=1).groupby(level=0).sum()
skin.index = skin.index.astype(str).str.upper()

bulk_configs = {
    "GSE293179": "entrezgene", # Lung
    "GSE292944": "ensembl.gene", # Bronchial
    "GSE304690": "ensembl.gene", # Retina
    "GSE115828": "ensembl.gene"  # AMD Anchor
}

final_dfs = [gut, skin]

for gse, scope in bulk_configs.items():
    f_path = glob.glob(os.path.join(raw_dir, f"*{gse}*"))[0]
    print(f"Harmonizing {gse}...")
    sep = ',' if f_path.endswith('.csv.gz') else '\t'
    df = pd.read_csv(f_path, sep=sep, index_col=0)
    df.index = clean_index(df)
    df = map_to_symbols(df, scope)
    final_dfs.append(df)

print("Performing final intersection merge...")
master = pd.concat(final_dfs, axis=1, join='inner')
master.to_csv(os.path.join(proc_dir, "Master_Raw_Counts.csv"))
print(f"\nSUCCESS! Final Matrix Shape: {master.shape}")
