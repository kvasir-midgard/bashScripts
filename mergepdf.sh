#!/bin/bash

FILES=$1

OUTPUT=$(zenity --forms --title="Merge Pdf's" --text="Merge Pdf Name" --separator="," --add-entry="File Name")

accepted=$?
if ((accepted != 0)); then
    echo "something went wrong"
    exit 1
fi

name=$(awk -F, '{print $1}' <<<$OUTPUT)

if [ -z "$name" ]; then
	name="finished"
fi


gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=$name.pdf $FILES