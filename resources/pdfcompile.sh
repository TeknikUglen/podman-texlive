#!/usr/bin/bash

#
# Script will build pdf file from tex file. 
# output filename will be the same as input unless a second argument is supplied.
# Requires the tex file as the first argument.
#
# Will rebuild as long as references are not OK. (reacts to: "Rerun LaTeX")
#

if [[ "$1" == "" ]]; then
    echo "Required argument missing"
    echo "Usage: "
    echo "$0 <file.tex> <output name>"
    echo "   output name is optional!"
    exit 1
fi

extension="${1##*.}"
if [[ "$extension" != "tex" ]]; then
    echo "input tex file cannot be found! Exiting."
    exit 1
fi

if [[ "$2" == "" ]]; then
    command="xelatex -halt-on-error $1"
else
    basename=$2
    if [[ "$2" == *.* ]]; then
        basename=${2%.*}
    fi
    command="xelatex -halt-on-error -jobname=$basename $1"
fi
rm -f build.log

echo "************ Start ************" | tee -a build.log
date=$(date -u '+%Y-%m-%d %H:%M:%S')
echo "UTC $date"  | tee -a build.log
echo -e "\n********** Run build **********\n" | tee -a build.log

while true; do

output=$($command | tee -a build.log )
echo -e "$output" # will echo $command output to screen.

if [[ $output =~ "Rerun LaTeX" ]]; then
    echo -e "\n********** Run again **********\n" | tee -a build.log
else
    break
fi

done
echo -e "\nCheck 'build.log' for details."
echo "************ Done *************" | tee -a build.log
