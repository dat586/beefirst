#!/bin/bash

topHeader=$(top -b -n 1 | sed -n '7p')
topOutput=$(top -b -n 1 | sed '1,7d')  # Using top to avoid permission issues with viewing processes
IFS='
'  # Change field separator to new line

declare -a report=()  # Declare empty report array
report+=("$topHeader")  # Write top header to report
for process in $topOutput  # Loop over processes
do
    cpu=$(echo "$process" | awk '{print $9}')  # Find CPU metric and assign
    mem=$(echo "$process" | awk '{print $10}')  # Find memory metric and assign
    cpuHigh=$(echo "$cpu > 50" | bc -l)  # Evaluate if CPU is over 50%, returns 1 if true
    memHigh=$(echo "$mem > 50" | bc -l)  # Evaluate if CPU is over 50%, returns 1 if true
    if [[ $cpuHigh == 1 || $memHigh == 1 ]]; then
        report+=("$process")  # If CPU or memory is over 50%, write the process to the report
    fi
done

echo "${report[*]}"  # Display report
