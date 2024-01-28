#!/bin/bash

topHeader=`top -b -n 1 | sed -n '7p'`
topOutput=`top -b -n 1 | sed '1,7d'`
IFS='
'

declare -a report=()
report+=("$topHeader")
for process in $topOutput
do
    cpu=$(echo "$process" | awk '{print $9}')
    mem=$(echo "$process" | awk '{print $10}')
    cpuHigh=$(echo "$cpu > 50" | bc -l)
    memHigh=$(echo "$mem > 50" | bc -l)
    if [[ $cpuHigh == 1 || $memHigh == 1 ]]; then
        report+=("$process")
    fi
done

echo "${report[*]}"
