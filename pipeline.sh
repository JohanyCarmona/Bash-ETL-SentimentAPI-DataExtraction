#!/bin/bash
echo '
Updated on Jun 18, 2020

By Johany A. Carmona C.
Email: johany.carmona@pm.me; johany.carmona@tuta.io

Info: Execute extracting process to get Sentiment score from multiples .*.csv files. The score will be evaluated from first column of .csv file.

Help: Execute from bash terminal using the following command.

Tip: Remember enable execution permission from each related file: extract.sh and pipeline.sh.

Command: ./pipeline.sh [pipeFilename]

Where [pipeFilename] contains each one of files to execute the process:
/data/filename0
/data/filename1
...
/data/filenameN

'
PIPELINE=$1

count=0
while IFS= read -r line; do
  count=$((count+1))
  echo Pipeline: filename $count
  filename=$line
  ./extract.sh $filename.trm
  echo $filename.trm.ext have been successfully created.

done < $PIPELINE
