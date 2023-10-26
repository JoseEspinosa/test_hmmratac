#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { HMMRATAC } from './modules/hmmratac_run/main'

params.input_path = "${projectDir}/small_data" 

bam_files = Channel.fromPath("${params.input_path}/*.bam") 
bai_files = Channel.fromPath("${params.input_path}/*.bai")

bam_files
    .map { [ it.name.split("\\.")[0], it ] }
    .set { bam_files_id }

bai_files
    .map { [ it.name.split("\\.")[0], it ] }
    .set { bai_files_id }    


bam_files_id
    .join (bai_files_id)
    .set {bam_bai_ch}

bam_bai_ch.view()

workflow HMMRATAC_RUN {
    HMMRATAC (bam_bai_ch)
}

workflow {
    HMMRATAC_RUN ()
}