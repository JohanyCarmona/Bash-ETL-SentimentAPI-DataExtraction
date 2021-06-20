# Bash-ETL-SentimentAPI-DataExtraction
####
Execute extracting process to get Sentiment score from multiples .*.csv files. The score will be evaluated from first column of .csv file.
####
By Johany A. Carmona C.
####
Email: johany.carmona@pm.me; johany.carmona@tuta.io

### About: API
###
The script will be done for Meaning Cloud Sentiment-V2.1, if you will use other API request, please change the following curl request from extract.sh.
```
curl 'https://api.meaningcloud.com/sentiment-2.1' \
  -F 'key=YOUR_API_KEY' \
  -F 'lang=en' \
  -F 'model=general' \
  -F 'txt=YOUR_REQUEST'
```

### About: pipeline.sh
####
Info: Execute extracting process to get Sentiment score from multiples .*.csv files. The score will be evaluated from first column of .csv file.
####
Help: Execute from bash terminal using the following command.
####
Tip: Remember enable execution permission from each related file: extract.sh and pipeline.sh.
####
Command: `./pipeline.sh [pipeFilename]`
####
Where [pipeFilename] contains each one of files to execute the process:
```
/data/filename0
/data/filename1
...
/data/filenameN
```
### About: extract.sh
####
Info: Execute extracting process to get Sentiment score from am.csv file. The score will be evaluated from first column of .csv file.
####
Help: Execute from bash terminal using the following command.
####
Tip: Remember enable execution permission from each related file: extract.sh and pipeline.sh.
####
Command: `./extract.sh [filename]`
####
Where [filename] is a default .csv file and contains each one of rows to execute the process:
```
firstColumnOfRow1,...,nColumnOfRow1
firstColumnOfRow2,...,nColumnOfRow2
...
firstColumnOfRowN,...,nColumnOfRowN
```
