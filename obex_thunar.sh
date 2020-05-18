#!/bin/bash
while true; do
	echo ""
	echo "Mount Bluetooth Device"

	echo "1) Mount Device"
	echo "2) bluetooth command line tool"
	echo "q) Quit"
	echo ""

	printf "user input: "
	read -a OPTIONS_1S

	for OPT_1S in ${OPTIONS_1S[@]}; do

		case "$OPT_1S" in
			1)
				mountpoint="/home/`whoami`/Bluetooth-$1"
				mkdir $mountpoint

				obexfs -b $1 $mountpoint
				;;
			2)
				echo "enter help for list of commands"
				bluetoothctl
				;;
			q)
				removemount="/home/`whoami`/Bluetooth-$1"
				fusermount -u $removemount
				rm -rf $removemount
				;;
			*)
				echo "(!) choice invalid "
				;;
		esac
	done
done