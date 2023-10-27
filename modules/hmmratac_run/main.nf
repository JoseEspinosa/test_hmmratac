process HMMRATAC {
    tag "$id"
    label 'process_medium'

    container 'joseespinosa/macs3:3.0.0b3'

    input:
    tuple val(id), path(bam), path(bai)

    output:
    tuple val(id), path("*.tsv")       , emit: tsv
    tuple val(id), path("*.json")      , emit: model
    tuple val(id), path("*.gappedPeak"), emit: peaks

    """
    macs3 hmmratac -b $bam -n $id
    """
}