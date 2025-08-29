# BLAST Tools

This folder contains scripts for searching genes of interest in complete genomes using **BLAST+** and extracting their sequences (with or without flanking regions). These scripts are useful for tasks such as finding homologs, retrieving genomic coordinates, or designing primers for gene editing.

---

## Contents
- **`blast_extract_best.sh`** → Runs BLAST against a genome and extracts the **best hit** (highest bitscore).
- **`blast_extract_flanks.sh`** → Same as above, but also extracts the gene sequence with **±1 kb flanking regions**, useful for primer design.

---

## Requirements
Install dependencies with **conda**:

```bash
conda create -n blast_env -c bioconda blast samtools seqkit
conda activate blast_env
```

- BLAST+ → for sequence alignment (blastn, makeblastdb).
- samtools → to extract sequences from the genome FASTA by coordinates.
- seqkit → to reverse-complement sequences when hits are found on the minus strand.
