import pandas as pd
import os

base_dir = os.path.expanduser("~/Epithelial_OxStress_Meta")
counts_path = os.path.join(base_dir, "data/processed/Master_Raw_Counts.csv")
meta_path = os.path.join(base_dir, "data/processed/metadata.csv")

counts_df = pd.read_csv(counts_path, index_col=0, nrows=0)
samples = counts_df.columns.tolist()

metadata = []
for s in samples:
    if s == "Symbol": continue

    if "Asp_" in s or "Control_" in s:
        batch = "GSE285905_Gut"
    elif s.startswith("GSM3955"):
        batch = "GSE134533_Skin"
    elif "PTP_" in s:
        batch = "GSE293179_Lung"
    elif "Donor" in s:
        batch = "GSE292944_Bronchial"
    elif s.startswith("GSM8841") or any(k in s for k in ["HG_", "MG_", "LG_"]):
        batch = "GSE304690_Retina"
    elif s.startswith("GSM") or s.startswith("SRR"):
        batch = "GSE115828_AMD"
    else:
        batch = "Other_Study"

    control_keywords = ["CONTROL", "NOUV", "UNTREATED", "SHAM", "NORMAL", "FA_", "CTP", "LG_", "MG_"]
    is_control = any(k in s.upper() for k in control_keywords)
    
    condition = "Control" if is_control else "OxStress"
    
    metadata.append({"Sample_ID": s, "Batch": batch, "Condition": condition})

meta_df = pd.DataFrame(metadata)
meta_df.to_csv(meta_path, index=False)

print(f"Metadata generated for {len(meta_df)} samples.")
print(f"Final Batches: {meta_df['Batch'].unique()}")
