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

## Input Files

- gen_interes.fasta: query sequence (gene of interest, nucleotide).
- *.fasta: genome(s) where the search will be performed

## Usage

## 1. Extract the best BLAST hit

```bash
bash blast_extract_best.sh
```

This will:
- Create BLAST databases from the genomes.
- Search the query gene against each genome.
- Save the best hit (highest bitscore) for each genome in:
  - resultados_todos.txt (summary table).
  - GENOME_hit.fasta (FASTA file with the best hit sequence).

## 2. Extract best hit with ±1 kb flanks

```bash
bash blast_extract_flanks.sh
```

This will additionally generate:
- Genome_flank.fasta: gene sequence with ±1 kb upstream and downstream regions.

## Output Files

- resultados_todos.txt: tab-delimited summary with the best BLAST hit per genome.
- *_hit.fasta: FASTA file containing the best gene hit sequence.
- *_flank.fasta: FASTA file containing the best hit plus ±1 kb flanking regions.

## Example
If you have the following files:
- gen_interes.fasta
- SA.fasta
- SCH.fasta
- SJ.fasta

Run:
```bash
bash blast_extract_flanks.sh
```
Outputs:

- resultados_todos.txt
- SA_hit.fasta
- SA_flank.fasta
- SCH_hit.fasta
- SCH_flank.fasta
- SJ_hit.fasta
- SJ_flank.fasta

## Example content of resultados_todos.txt

```
genome  qseqid  sseqid   pident  length  mismatch  gapopen  qstart  qend  sstart  send   evalue    bitscore
SA      geneX   contig1  99.8    1000    2         0        1       1000  2000    3000   1e-100    500
SCH     geneX   contig5  98.5    990     3         0        1       990   15000   15990  2e-90     480
SJ      geneX   contig2  97.0    950     5         1        10      960   8000    8950   1e-80     450
```


## Author
Jennifer Molinet- Instituto de Ciencias Aplicadas- Universidad Autónoma de Chile
