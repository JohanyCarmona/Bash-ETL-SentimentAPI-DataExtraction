#!/bin/bash
echo '
Updated on Jun 19, 2020

By Johany A. Carmona C.
Email: johany.carmona@pm.me; johany.carmona@tuta.io

Info: Execute extracting process to get Sentiment score from am.csv file. The score will be evaluated from first column of .csv file.

Help: Execute from bash terminal using the following command.

Tip: Remember enable execution permission from each related file: extract.sh and pipeline.sh.

Command: ./extract.sh [filename]

Where [filename] is a default .csv file and contains each one of rows to execute the process:
firstColumnOfRow1,...,nColumnOfRow1
firstColumnOfRow2,...,nColumnOfRow2
...
firstColumnOfRowN,...,nColumnOfRowN
'

FILENAME=$1

API_URL='https://api.meaningcloud.com/sentiment-2.1'
API_KEY='YOUR_API_KEY'
LANGUAGE='en'
GENERAL='general'

#Row pattern
ROW_PATTERN='(.*)[.]($)'
#First column pattern
COLUMN_PATTERN='(.*)[[,].+]*.($)'
#EOF char delete pattern
EOF_PATTERN='(.*)(.$)'

#Add Sentiment Column to head
command=$(head -1 $FILENAME)

#Deleting EOF char
if [[ $command =~ $EOF_PATTERN ]]; then
  command=${BASH_REMATCH[1]}
fi

#Adding Sentiment keyword on head of file.
echo "$command"',\"Sentiment\"' > $FILENAME.ext
#Creating json log file registry
echo json_output > $FILENAME.ext.log

count=0
while IFS= read -r line; do
  row=$line
  
  #Getting row
  while [[ $row =~ $ROW_PATTERN ]]; do
    row=${BASH_REMATCH[1]}${BASH_REMATCH[2]}
  done
  
  #Getting first column
  column=$row
  while [[ $column =~ $COLUMN_PATTERN ]]; do
    column=${BASH_REMATCH[1]}${BASH_REMATCH[2]}
  done
  
  #Send api request
  output=$(curl $API_URL \
    -F 'key='$API_KEY \
    -F 'lang='$LANGUAGE \
    -F 'model='$GENERAL \
    -F 'txt='"$column")
  
  #Adding output log result
  echo $output >> $FILENAME.ext.log
  
  count=$((count+1))
  #Getting message status
  msg=$(jq .status.msg <<< "$output")
  
  if [[ msg="OK" ]];then
    #Getting sentiment score
    score=$(jq .score_tag <<< "$output")
    
    #Deleting EOF char
    if [[ $row =~ $EOF_PATTERN ]]; then
      row=${BASH_REMATCH[1]}
    fi
    
    #Adding sentiment score
    row="$row"','"$score"
    
    #Adding row to output file
    if [[ $count > 0 ]];then
      if [[ $count > 1 ]];then
        echo $row >> $FILENAME.ext
      fi
      echo Extract: row $count
    fi
  
  #api error response
  else
    echo Extract error: line $count
  fi

#Reading input filename
done < $FILENAME

