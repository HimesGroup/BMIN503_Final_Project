#!/usr/bin/python
import argparse
import sys
import subprocess
import os

def lsf_file(job_name, cmd, memory=36000, thread=1):
    """
    Creates .lsf files
    """

    outp = open(job_name+".lsf",'w')
    outp.write("#!/bin/bash\n")
    outp.write("#BSUB -L /bin/bash\n")
    outp.write("#BSUB -J "+job_name+"\n")
    outp.write("#BSUB -q normal\n")
    outp.write("#BSUB -o "+job_name+"_%J.out\n")
    outp.write("#BSUB -e "+job_name+"_%J.screen\n")
    outp.write("#BSUB -M "+str(memory)+"\n")
    outp.write("#BSUB -n "+str(thread)+"\n")
    outp.write(cmd)
    outp.write("\n")
    outp.close()



def main(samp_info, DE_dir, script_dir, study, tissue, disease, treatment, out, method):
    """
    Run meta-analysis using meta_analysis_microarry.R
    """

    # check exists of script directory
    if script_dir == "./":
        script_dir = os.getcwd()
    if script_dir[-1] != "/":
        script_dir = script_dir+"/"

    out_dir=os.path.dirname(out)
    if not os.path.exists(out_dir):
        os.makedirs(out_dir)
        print "Create output directory" +out_dir

    if not os.path.isfile(script_dir+"meta_analysis_geneexpr.R"):
        print "R script file meta_analysis_geneexpr.R does not exist in "+script_dir
        sys.exit()

    if not os.path.isfile(script_dir+"integration_utility.R"):
        print "R utility script file integration_utility.R does not exist in "+script_dir
        sys.exit()

    if method=="rankprodt":
        if not os.path.isfile(script_dir+"meta_analysis_RankProd.R"):
            print "R script file meta_analysis_RankProd.R for rank product permutation does not exist in "+script_dir
            sys.exit()

    if (disease is not None) and (treatment is not None):
        print "Both disease endotype and treatment are specified. The runtime will be doubled."
        print "You can just specify disease endotype or treatment to reduce the runtime"

    if study is None:
        study="NA"
    else:
        tissue="NA"
        disease="NA"
        treatment="NA"

    if disease is None:
        disease="NA"

    if treatment is None:
        treatment="NA"

    cmd="Rscript --vanilla "+script_dir+"meta_analysis_geneexpr.R \""+samp_info+"\" \""+DE_dir+"\" \""+script_dir+"\" \""+study+"\" \""+tissue+"\" \""+disease+"\" \""+treatment+"\" \""+out+"\" \""+method+"\""
    print "Run R commad..."
    print cmd
    os.system(cmd)

    # Create 1000 .lsf files for 1,000,000 permutations
    if method=="rankprodt":
        if not os.path.exists(out+".ranklist.RDS"):
            print "Input rank list RDS file "+out+".ranklist.RDS"+" does not exist."
            sys.exit()

        # create a directory to put subpermutation files
        new_dir=out+"_rankperm"
        if not os.path.exists(new_dir):
            os.makedirs(new_dir)
            print "Create new directory "+new_dir+" to save sub-permutation results"
        else:
            print "Directory "+new_dir+" already exists. Please check!"
            sys.exit()

        print "Create 20 .lsf files..."
        # create 20 LSF files for 1000 sub-permutation
        seeds=range(1,1000000,50000) # 20 seeds: 1, 5001, 10,001,...,950,001
        i=0
        # number of cores used
        ncore=10
        for seed in seeds:
            i=i+1
            # R script arguments: V1: script dir, V2: input RDS, V3: nperm in sub-permutation, V4: random seed, V5: number of cores (use 10), V6: output prefix, usually named by seeds, V7: result directory
            out_prefix=str(seed)
            cmd="time Rscript --vanilla "+script_dir+"meta_analysis_RankProd.R "+script_dir+" "+out+".ranklist.RDS 50000 "+str(seed)+" "+str(ncore)+" "+" "+out_prefix+" "+new_dir # use seed as output prefix
            lsf_file("rank_"+str(seed), cmd, memory=24000, thread=ncore)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Meta-analysis of transcriptomic data")
    parser.add_argument("--samp_info", type=str, help="sample info sheet .RDS for all studies")
    parser.add_argument("--DE_dir", type=str, default="./", help="directory with .RDS files of DE results")

    parser.add_argument("--script_dir", type=str, default="./", help="directory to put R script files meta_analysis_geneexpr.R and integration_utility.R for meta-analysis")
    parser.add_argument("--study", type=str, help="study based on Unique_ID from Sample Info Sheet. If specified, ignore other filtrations")
    parser.add_argument("--tissue",type=str, help="tissue: entire or ASM BAL BE CD4 CD8 chALL LCL LEC Lung MACRO MCF10A-Myc NE PBMC SAE U2OS WBC. Use quote for multiple tissues")
    parser.add_argument("--disease", type=str, help="disease: entire or allergic_asthma, asthma, asthma_and_rhinitis, fatal_asthma, non_allergic_asthma, non_severe_asthma, severe_asthma. Use quote for multiple disease endotype(s)")
    parser.add_argument("--treatment", type=str, help="treatment: GC BA_GC vitD. Use quote for treatment(s)")
    parser.add_argument("--out", type=str, default="out", help="output file name prefix including directory path (default=out)")
    parser.add_argument("--method", type=str, default="metaranef", help="Methods used for integration. Options: metaranef, fisherp, rankprodt (default=metaranef)")

    args = parser.parse_args()

    if len(sys.argv)==1:
        parser.print_help()
        sys.exit(1)

    if args.samp_info is None:
        print "--samp_info option is required"
        parser.print_help()
        sys.exit(1)
        
    if args.DE_dir is None:
        print "--DE_dir option is required"
        parser.print_help()
        sys.exit(1)

    if args.study is None:
        if args.tissue is None:
            print "Please specify tissue(s)."
            sys.exit(1)

        if (args.disease is None) and (args.treatment is None):
            print "Please specify disease endotype(s) or treatment(s)"
            sys.exit(1)

    else:
        print "Selection only based on unique ID. Ignore other specified filtrations, e.g. tissue, disease, treatment"

    if args.method not in ["metaranef", "fisherp", "rankprodt"]:
        print "Please check method options."
        sys.exit(1)

    main(args.samp_info, args.DE_dir, args.script_dir, args.study, args.tissue, args.disease, args.treatment, args.out, args.method)
