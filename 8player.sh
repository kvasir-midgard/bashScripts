#!/bin/bash

### prints line across mixinal ###
print_line() {
	printf "%$(tput cols)s\n"|tr ' ' '-'
}

play_loop() {
	if [[ -n $mix ]]; then
		MIX=$mix
		
		echo ""
		echo "Slected mix is is $MIX"
		
		echo "" >> $HOME/Music/8tracks
		echo $MIX >> $HOME/Music/8tracks
		
		echo "1) Play Mix"
		echo "2) Continuous playback with similar mixes"
		echo "3) Display extended mix info"
		echo "b) Back"
		echo ""
		
		printf "user input: "
		read -a OPTIONS_1S

		for OPT_1S in ${OPTIONS_1S[@]}; do

			case "$OPT_1S" in
				1)
					8play -P $MIX
					;;
				2)
					8play -c $MIX
					;;
				3)
					8play -Q $MIX
					;;
				b)
					;;
				*)
					echo "(!) choice invalid "
					;;
			esac
		done
	else
		echo "Exiting to main menu."
		break
	fi
}


printline="------------------------------------------------------------"


# main loop
while true; do

	### List options ###
	echo ""
	echo "8play: An unofficial command-line player for 8tracks.com"
	print_line
	echo "1) Search All"
	echo "2) Search Artist"
	echo "3) Search Tags"
	echo "4) Search Keyword"
	echo "5) Play URL"
	echo "6) Controls & Input"
	echo "q) Quit"
	echo ""

	printf "user input: "
	read -a OPTIONS

	for OPT in ${OPTIONS[@]}; do

		case "$OPT" in
			1)
				echo ""
				echo "Search the unfiltered set of all mixes."
				echo "order by recent for recent mixes."
				echo "order by popular for popular mixes."
				echo "order by hot for hot mixes. [DEFAULT]"
				print_line
				
				read -p "Input (r)recent, (p)popular, or hit enter for hot: " inptall
				
				if [[ $inptall == "r" || $inptall == "R" ]]; then
					inptall="recent"
				elif [[ $inptall == "p" || $inptall == "P" ]]; then
					inptall="popular"
				else
					inptall="hot"
				fi

				echo""
				read -p "Input page number (hit enter for first page): " page
				page=${page:-1}

				alllist=$(8play -S -p $page -i 18 all:$inptall | sed '/^[ \t]/d' && 
					echo $printline && echo "{b}Back")
				PS3='Which mix do you want to play? '
				
				echo ""
				select mix in $alllist; do

					case $mix in
						{b}Back)
							echo "Exiting to main menu."
							break
						;;

						$printline)
							echo "(!) choice invalid "
						;;
						
						*)
							play_loop
						;;
					esac
				done
				;;
			2)
				echo ""
				echo "Search mixes filtered by artist match within the tracklist."
				echo "Example: Kanye_West, N^W^A"
				print_line
				
				read -p "Input artist name: " inptartist

				echo""
				read -p "Input (p)popular, (r)recent, or enter for hot: " prh
				
				if [[ $prh == "r" || $prh == "R" ]]; then
					prh=":recent"
					inptartist=$inptartist$prh
				elif [[ $prh == "p" || $prh == "P" ]]; then
					prh=":popular"
					inptartist=$inptartist$prh
				else
					prh=":hot"
					inptartist=$inptartist$prh
				fi

				echo""
				read -p "Input page number (hit enter for first page): " page
				page=${page:-1}
				
				artistlist=$(8play -S -p 1 -i 18 artist:$inptartist | sed '/^[ \t]/d' && 
					echo $printline && echo "{b}Back")
				PS3='Which Mix do you want to play? '
				
				echo ""
				select mix in $artistlist; do
					case $mix in
						{b}Back)
							echo "Exiting to main menu."
							break
						;;

						$printline)
							echo "(!) choice invalid "
						;;
						
						*)
							play_loop
						;;
					esac
				done
				;;
			3)
				echo ""
				echo "Search mixes filtered by a tag or multiple tags."
				echo "Example: hip_hop, hip_hop+old-school"
				print_line
				
				read -p "Input tag / tag's: " inpttag

				echo""
				read -p "Input (p)popular, (r)recent, or enter for hot: " prh
				
				if [[ $prh == "r" || $prh == "R" ]]; then
					prh=":recent"
					inpttag=$inpttag$prh
				elif [[ $prh == "p" || $prh == "P" ]]; then
					prh=":popular"
					inpttag=$inpttag$prh
				else
					prh=":hot"
					inpttag=$inpttag$prh
				fi
				
				echo""
				read -p "Input page number (hit enter for first page): " page
				page=${page:-1}
				
				taglist=$(8play -S -p 1 -i 18 tags:$inpttag | sed '/^[ \t]/d' && 
					echo $printline && echo "{b}Back")
				PS3='Which Mix do you want to play? '
				
				echo ""
				select mix in $taglist; do
					case $mix in
						{b}Back)
							echo "Exiting to main menu."
							break
						;;

						$printline)
							echo "(!) choice invalid "
						;;
						
						*)
							play_loop
						;;
					esac
				done
				;;
			4)
				echo ""
				echo "Search fulltext search results for a string, ordered by relevance."
				print_line
				
				read -p "Input keyword: " inptkeyword
				
				echo""
				read -p "Input page number (hit enter for first page): " page
				page=${page:-1}
				
				keywordlist=$(8play -S -p 1 -i 18 keyword:$inptkeyword | sed '/^[ \t]/d' && 
					echo $printline && echo "{b}Back")
				PS3='Which Mix do you want to play? '
				
				echo ""
				select mix in $keywordlist; do
					case $mix in
						{b}Back)
							echo "Exiting to main menu."
							break
						;;

						$printline)
							echo "(!) choice invalid "
						;;
						
						*)
							play_loop
						;;
					esac
				done
				;;
				
			5)
				echo ""
				echo "Play mix using url"
				print_line
				
				read -p "Input URL: " url
				echo ""
				
				echo "" >> $HOME/Music/8tracks
				echo $url >> $HOME/Music/8tracks
				
				echo "1) Play Mix"
				echo "2) Continuous playback with similar mixes"
				echo "3) Display extended mix info"
				echo "b) Back"
				echo ""
				
				printf "user input: "
				read -a OPTIONS_1S

				for OPT_1S in ${OPTIONS_1S[@]}; do

					case "$OPT_1S" in
						1)
							8play $url
							;;
						2)
							8play -c $url
							;;
						3)
							8play -Q $url
							;;
						b)
							
							;;
						*)
							echo "(!) choice invalid "
							;;
					esac
				done
				;;

			6)
				echo ""
				print_line
				echo "CONTROLS"
				print_line
				
				echo "The following keyboard controls can be used during playback:"
				echo ""
				echo "       >           Skip mix."
				echo "       ENTER       Skip track."
				echo "       p / SPACE   Pause (pressing again unpauses)."
				echo "       q / CTRL-c  Stop playing and quit."
				
				echo ""
				print_line
				echo "INPUT"
				print_line
				
				echo "Input can consist out of keywords, artists, or tags depending on the type that is specified."
				echo "Input has to be a UTF-8 and URL-safe string."
				echo "In order to achieve this the following substitution rules apply to all input:"
				echo ""
				echo "       * Underscores '_' should be replaced with double underscores '__'."
				echo "       * Spaces ' ' should be replaced with underscores '_'."
				echo "       * Forward slashes '/' should be replaced by backslashes '\'."
				echo "       * Periods or dots '.' should be replaced by carets '^'."
				echo ""
				print_line
				;;
			q)
				exit 1
				;;
			*)
				echo "(!) choice invalid "
				;;
		esac
	done
done