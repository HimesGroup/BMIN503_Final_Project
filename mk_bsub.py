#! /usr/bin/python
import argparse
import sys
import os
import re

def check_line(line_total, line_num): # check if total number of lines can be divided by line_num that you want to repeat

    if not line_total % line_num == 0:
        print("The total of lines in the input file cannot be divided by the number of command lines (--line) you'd like for each bsub file")
        sys.exit(1)

def check_file(fn): # check if a file exists

    if os.path.exists(fn):
        print("The file "+fn+" already exists. Overwrite it!")


def bsub_create(path, job_name, queue, memory, thread, out): # write out the standard part of bsub script

    out.write("#!/bin/bash\n")
    out.write("#BSUB -L /bin/bash\n")
    out.write("#BSUB -J "+str(job_name)+"\n")
    out.write("#BSUB -q " +str(queue)+"\n")
    out.write("#BSUB -outdir "+str(path)+"\n")
    out.write("#BSUB -o "+str(job_name)+"_%J.out"+"\n")
    out.write("#BSUB -e "+str(job_name)+"_%J.screen\n")
    out.write("#BSUB -M "+str(memory)+"\n")
    out.write("#BSUB -n "+str(thread)+"\n")

def main(path, line_num, job_name, queue, memory, thread, lines):

    # check if total nuber of lines can be divided by line_num that you want to repeat
    check_line(len(lines),line_num)

    # output bsub script based on the number of lines used for one job
    if len(lines)==line_num: # if all lines from input file are used for one bsub script, use the job_name as output file name
        out_prefix=job_name # create output file name
        out_fn=path+"/"+out_prefix+".lsf"
        check_file(out_fn)
 	out=open(out_fn,'w')
	bsub_create(path, out_prefix, queue, memory, thread, out) # job name is consistent with the assigned job name
	for line in lines:
	    out.write(line+"\n")
	out.close()


    else: # if the lines from input file are splitted into separate bsub files
        fn_idx=1
        for idx in range(0, len(lines), line_num): # get the first line index (idx) for every line_num of lines
            out_prefix=job_name+"_"+str(fn_idx) # create separate output file name
            out_fn=path+"/"+out_prefix+".lsf"
            check_file(out_fn)
            out=open(out_fn,'w')
            bsub_create(path, out_prefix, queue, memory, thread, out) # change job name to bsub script file name
            for idx2 in range(0,line_num,1): # get line indexes (idx2) from the first line to the line_num of line
                out.write(lines[idx+idx2]+"\n")
            out.close()
            fn_idx=fn_idx+1


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Create .lsf file for bsub use \
        [Usage]: echo foo | mk_bsub.py --line 1 --job_name out --queue normal --memory 36000 --thread 12")
    parser.add_argument("--path", default=".", type=str, help="working directory to store output files from a job, default=current working directory")
    parser.add_argument("--line", default=1, type=int, help="number of lines from input file as one job, default=out")
    parser.add_argument("--job_name", default="out", type=str, help="job name, default=out")
    parser.add_argument("--queue", default="normal", type=str, help="queue, default=normal")
    parser.add_argument("--memory", default=36000, type=int, help="memory, default=36000")
    parser.add_argument("--thread", default=12, type=int, help="number of threads, default=12")
    args = parser.parse_args()

    if sys.stdin.isatty(): # if standard input does not exist, print help
        print("Input data does not exist!")
        parser.print_help()
        sys.exit(1)

    path=args.path
    line_num=args.line
    job_name=args.job_name
    queue=args.queue
    memory=args.memory
    thread=args.thread

    lines=[line.rstrip('\n') for line in sys.stdin.readlines()] # read standard input into a character and split by "\n"

    path = re.sub('\/$', '', path) # remove last "/" character from path
    if (path=="."):
        path=os.getcwd()

    if not os.path.exists(path): # check if path exists
        print("Output directory does not exist!")
        sys.exit(1)

    if (path=="."):
        path=os.getcwd()

    main(path, line_num, job_name, queue, memory, thread, lines)

