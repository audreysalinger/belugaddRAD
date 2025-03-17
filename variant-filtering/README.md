## Scripts used for variant filtering

- **16_filter-sites-for-missingness.sh** (filter to remove sites missing >40% of data)
- **17_missingness-report-by-sample.sh** (generate a report of missingness by sample to identify samples missing >50% of genotype calls)
- **18_refilter-sites-for-missingness.sh** (filter to remove sites missing >20% of genotypes)
- **19_vcf-stats.sh** (compile VCF statistics after filtering for missing data)
- **20_remove-repetitive-regions.sh** (remove repetitive regions identified by the RepeatMasker file that accompanied the reference genome)
- **21_stats-report-norepeats.sh** (generate an updated statistics report for the resulting VCFs)
- **22_biallelic-snps.sh** (remove invariant sites from the VCFs and retain only biallelic SNPs)
- **23_replicate-gtcheck.sh** (assess genotype consistency between replicate samples added during library prep)
- **24_remove-replicates-fill-tags.sh** (remove the 5 replicate samples)
- **25_remove-lowfreq-variants.sh** (remove low frequency variants on the basis of MAF and MAC)
- **26_remove-duplicate-records.sh** (where there are multiple records for the same site, remove duplicates and retain only the first record)
