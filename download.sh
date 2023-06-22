#!/bin/bash

## linux bash threaded curl downloader ##
## by d7x ##
## d7x.promiselabs.net ##

COUNTER=0 
THREADS=40
DELAY=10
INPUT_FILENAME="urls"
OUTPUT_DIRECTORY="download"

for i in $(cat ${INPUT_FILENAME}) 
do
        total=`ls -al ${OUTPUT_DIRECTORY} | wc -l`
        banner="\rReached threshold, sleeping for $DELAY seconds / Downloded: $total file(s)"
        echo -ne "\rDownloading..."
        printf "%*s" `expr ${#banner} - 16`
        if [ $COUNTER -eq $THREADS ] 
        then
                # echo -ne "\rReached threshold, sleeping for $DELAY seconds / Downloded: $total file(s)  "
                echo -ne $banner
                sleep $DELAY
                COUNTER=0
        fi
        FILENAME=`basename $i`
        echo $i >> eyewitness_local/urls_local.txt
        curl -s -k -m 4 -f -o "${OUTPUT_DIRECTORY}/`basename $i`" $i -H "User-Agent: Mozilla/5.0" & 
        # echo $COUNTER &
        let COUNTER=COUNTER+1
done
