#!/bin/bash
# program that filters unmatched indices (reads with alignment(s) only in one chunk), to return only reads with matches in multiple fasta chunks
file=$1
split=$2
echo "processing "$file
file_name="${file%.*}"

awk -v NAME="$split" -v DIR="$1" '
{
        ## SELECT INDICES WITH A MATCH

        if ($3=="2F") {
                printf ("%s\t%s\n", $1, $2) > NAME".txt"
        }
}
END {
# in case there were no overlapping indices to correct, print a new line to the file
print ("\n") > NAME".txt"
}
' $1
