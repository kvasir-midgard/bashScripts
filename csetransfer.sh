#!/bin/bash

### prints line across mixinal ###
print_line() {
	printf "%$(tput cols)s\n"|tr ' ' '-'
}

while true; do
	
	### List options ###
	echo ""
	echo "Transfer files vis SCP"
	print_line
	echo "1) Copy from local to ieng6"
	echo "2) Copy from ieng6 to local"
	echo "3) Copy from local to raspi"
	echo "4) Copy from raspi to local"
	echo "q) Quit"
	echo ""
	
	printf "user input: "
	read -a OPTIONS
	
	for OPT in ${OPTIONS[@]}; do
		
		case "$OPT" in
			1)
				echo ""
				echo "input file / folder location: "
				read localfiles
				
				echo ""
				echo "Destination location: "
				read destination
				
				scp -r $localfiles j2villa@ieng6.ucsd.edu:$destination
				;;
			2)
				echo ""
				echo "input file / folder location: "
				read ieng6files

				echo ""
				echo "Destination location: "
				read destination
				
				scp -r j2villa@ieng6.ucsd.edu:$ieng6files $destination
				;;
			3)
				echo ""
				echo "input file / folder location: "
				read localfiles

				echo ""
				echo "Destination location: "
				read destination
				
				scp -r $localfiles pi@72.197.236.243:$destination
				;;
			4)
				echo ""
				echo "input file / folder location: "
				read pifiles

				echo ""
				echo "Destination location: "
				read destination
				
				scp -r pi@72.197.236.243:$pifiles $destination
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