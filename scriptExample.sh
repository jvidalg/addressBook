#!/bin/bash

while [ true ]
do
	IFS=$'\n'       # make newlines the only separator
	set -f          # disable globbing
	for i in $(cat customcrontab); do
		startDate=${i%%||*}
		task=${i##*||}
		periodTask=${i#*||}
		period=${periodTask%||*}

		startSecs=`date -d "$startDate" +%s`
		nowSecs=`date +%s`

		# Check if the start date has reached
		if (( $startSecs > $nowSecs )); then
			continue
		fi

		let modulus=($nowSecs-$startSecs)%$period
		if [ $modulus -eq 0 ]; then
			eval "$task &"
		fi
         	#test for git
	done
	sleep 1
done

