#!/bin/bash

set -o nounset # explode on undefined variables
set -e         # explode if any command fails


# Best way to shrink a PDF of scanned pages without losing quality. Found on
# http://ubuntuforums.org/archive/index.php/t-1133357.html

# example: ./shrink_pdf.sh big_file.pdf 600 small_file.pdf

in_file=$1
resolution=$2
out_file=$3

temp_file1=`mktemp`
temp_file2=`mktemp`

pdf2djvu -d $resolution $in_file -o $temp_file1
djvups $temp_file1 $temp_file2
ps2pdf $temp_file2 $out_file

rm -f $temp_file1 $temp_file2
