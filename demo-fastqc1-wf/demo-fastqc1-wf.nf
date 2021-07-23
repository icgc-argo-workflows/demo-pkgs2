#!/usr/bin/env nextflow

nextflow.enable.dsl = 2
version = '0.1.0.1'

// universal params go here, change default value as needed
params.container = ""
params.container_registry = ""
params.container_version = ""
params.cpus = 1
params.mem = 1  // GB
params.publish_dir = ""  // set to empty string will disable publishDir

// tool specific parmas go here, add / change as needed
params.input_file = ""
params.cleanup = true

include { cleanupWorkdir; getSecondaryFiles; getBwaSecondaryFiles } from './wfpr_modules/github.com/icgc-argo/demo-wfpkgs/demo-utils@1.3.0/main.nf' params([*:params, 'cleanup': false])
include { demoFastqc1 } from './wfpr_modules/github.com/icgc-argo-workflows/demo-pkgs1/demo-fastqc1@0.1.0.1/demo-fastqc1' params([*:params, 'cleanup': false])


// please update workflow code as needed
workflow DemoFastqc1Wf {
  take:  // update as needed
    input_file


  main:  // update as needed
    demoFastqc1(input_file)
    if (params.cleanup) { cleanupWorkdir(demoFastqc1.out, true) }

  emit:  // update as needed
    output_file = demoFastqc1.out.output_file
}


workflow {
  DemoFastqc1Wf(
    file(params.input_file)
  )
}
