#!/bin/bash

# loops to get new video
while true; do

	# main input
	echo ""
	echo "input url to download: "
	read url
	
	# get website and save in downloads folder
	wget --mirror -p --convert-links -P /$HOME/Downloads $url
	
done