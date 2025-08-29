#!/bin/bash

# Query (gene of interest, nucleotide sequence)
QUERY="gen_interes.fasta"

# List of genomes (FASTA files must exist: SA.fasta, SCH.fasta, SJ.fasta, etc.)
GENOMAS=("SA" "SCH" "SJ")

# Global results file with header
echo -e "genome\tqseqid\tsseqid\tpident\tlength\tmismatch\tgapopen\tqstart\tqend\tsstart\tsend\tevalue\tbitscore" > resultados_todos.txt

# Loop over genomes
for G in "${GENOMAS[@]}"; do
    GENOMA="${G}.fasta"
    DB="${G}_db"

    echo "Processing $GENOMA ..."

    # Create BLAST database
    makeblastdb -in $GENOMA -dbtype nucl -out $DB

    # Run BLAST and keep the best hit (highest bitscore)
    BEST_HIT=$(blastn -query $QUERY -db $DB \
        -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore" \
        | sort -k12,12nr | head -n 1)

    # Save to global results file
    echo -e "${G}\t${BEST_HIT}" >> resultados_todos.txt

    # Extract fields
    SSEQID=$(echo $BEST_HIT | awk '{print $2}')
    SSTART=$(echo $BEST_HIT | awk '{print $9}')
    SEND=$(echo $BEST_HIT | awk '{print $10}')

    # Ensure start < end
    if [ $SSTART -le $SEND ]; then
        REGION="${SSEQID}:${SSTART}-${SEND}"
        REVCOMP=0
    else
        REGION="${SSEQID}:${SEND}-${SSTART}"
        REVCOMP=1
    fi

    # Extract sequence with samtools
    samtools faidx $GENOMA $REGION > ${G}_hit_tmp.fasta

    # Reverse-complement if needed
    if [ $REVCOMP -eq 1 ]; then
        seqkit seq -r -p ${G}_hit_tmp.fasta > ${G}_hit.fasta
        rm ${G}_hit_tmp.fasta
    else
        mv ${G}_hit_tmp.fasta ${G}_hit.fasta
    fi

    echo "Best hit sequence saved in: ${G}_hit.fasta"
done
