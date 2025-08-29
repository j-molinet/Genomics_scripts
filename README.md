# Genomics Scripts

This repository contains a collection of scripts for different genomic analyses, mostly developed for *Saccharomyces* species but adaptable to other organisms.  
The repository is organized into thematic modules.

---

## Repository Structure
- **`blast_tools/`**: Search genes in genomes using BLAST, extract sequences, and generate flanking regions (±1 kb).
- **`examples/`**: Small toy datasets for demonstration (do not upload full genomes or large files here).

---

## Installation
Most scripts rely on tools available via **Bioconda**. You can create a conda environment with the main dependencies:

```bash
conda create -n genomics -c bioconda blast samtools seqkit bcftools control-freec
conda activate genomics

