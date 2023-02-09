#!/bin/bash

# Required package : mkvtoolnix-cli

MEDIA_PATH=$1
TRACK_LANG=$2
SUBTITLE_EXPORT_PATH=${MEDIA_PATH}

# change working directory
cd ${MEDIA_PATH}

# for loop all mkv file
for MKVFILE in *
do
    if [[ $MKVFILE == *.mkv || $MKVFILE == *.MKV ]]
    then
        #echo $MKVFILE
        # get track_id
        TRACK_ID=$(mkvinfo $MKVFILE | grep -E "Track number|Language" | grep $TRACK_LANG -B1 | awk -F'[()]' 'NR==1{gsub(/[^0-9]/,"",$2); print $2 }')
        # export subtitle track
        #echo $TRACK_ID
        SUBTITLE_FILE_NAME="${MKVFILE%.*}.${TRACK_LANG}.srt"
        echo $SUBTITLE_FILE_NAME
        mkvextract $MKVFILE tracks ${TRACK_ID}:${SUBTITLE_EXPORT_PATH}${SUBTITLE_FILE_NAME}
    fi
done



