#!/bin/bash

while true; do

	echo ""

	echo "input youtube url: "

	read url

        # youtube-dl -F $url
        
        # read -p "Please enter the desired quality # " FORMAT

	# youtube-dl -o - $url | castnow -

	# vlc --play-and-exit $(youtube-dl -g -f $FORMAT $url)

	vlc --play-and-exit $(youtube-dl -f 'bestvideo[height<=480]+bestaudio/best[height<=480]' $url)

done
