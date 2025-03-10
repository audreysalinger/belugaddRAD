## Scripts used to get from raw sequence reads to genotype calls

### 0. Checksums:
- md5_mod.sh (modify .md5 path names and run checksums)

### 1. Initial MultiQC:
- cp-fastqc-L1.sh (copy FastQC directories for lane 1)
- cp-fastqc-L2.sh (copy FastQC directories for lane 2)
- **01_initial-multiqc.sh** (run MultiQC on FastQC from sequencing facility for initial quality check)

### 2. Lane Effects:
- **02a_process_radtags-for-lane-effects.sh** (rough quality filtering to assess differences in lane performance)
- **02b_capture-process_radtags-LaneEffects.sh** (save the data for export)
- **03.1_bwa-index-subset.sh** (mapping a subset of samples to further assess lane performance - index reference genome)
- **03.2_subset-map-bwa-mem.sh** (mapping a subset of samples to further assess lane performance - map reads to reference)
- **03.3a_make-qualimap-input-subset.sh** (mapping a subset of samples to further assess lane performance - make qualimap input file)
- **03.3b_qualimap-subset.sh** (run Qualimap to check for any differences in mapping statistics between sequencing lanes)

### 3. Preprocessing reads:
- **04_concatenate-lanes.sh** (merge the two sequencing lanes so all reads are in one directory)
- **05_trim-R1-leading-bases.sh** (trim raw sequence reads)
- *06_copy-R2.sh* (move read 2 files to the input directory for Stacks)

### 4. Filtering reads:
- **07a_clone_filter.sh** (remove PCR duplicates) 
- **07b_extract-clone_filter.sh** (save log data for export)
- **08a_process_radtags.sh** (clean the reads)
- **08b_extract-process_radtags.sh** (save log data for export)
- **08c_extract-paired-read-counts.sh** (save log data for export)
- **09a_fastQC-postfilter.sh** (post filtering quality check with FastQC)
- **09b_multiQC-postfilter.sh** (run MultiQC for a report of the post-filtering sequence quality)

### 5. Mapping to reference genome:
- **10.1_filter-reference.sh** (filter reference genome to map to scaffolds >10Mbp)
- **10.2_bwa-index.sh** (index the filtered reference genome)
- **10.3_bwa-mem.sh** (map to the reference, convert to BAM, and sort the alignments)
- **11a_create-qualimap_input-file.sh** (create input file required for running Qualimap)
- **11b_qualimap-10M.sh** (run Qualimap to assess mapping statistics)
- **11c_multiQC-qualimap-10M.sh** (generate a report of mapping statistics using MultiQC)

### 6. Stacks reference-based pipeline:
- *12_make-popmap.sh* (create a population map)
- **13_ref_map-0.01.sh** (run Stacks ref_map.pl using alphas of 0.01)
- **14_ref_map-0.001.sh** (run Stacks ref_map.pl using alphas of 0.001)
- **15_ref_map-RDfilter.sh** (filter for read depth >5X and re-run Stacks ref_map.pl at both alpha stringencies)
