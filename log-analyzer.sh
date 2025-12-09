#!/bin/bash
COUNTS=5


echo -e "\nTop ${COUNTS} IP addresses with the most requests:"
awk '{print $1}' nginx-log.txt | sort | uniq -c | sort -nr |awk '{print $2 " - " $1 " requests"}' | head -n ${COUNTS}

echo -e "\nTop ${COUNTS} Most Requested Paths:"
awk '{print $7}' nginx-log.txt | sort | uniq -c | sort -nr |awk '{print $2 " - " $1 " requests"}' | head -n ${COUNTS}

echo -e "\nTop ${COUNTS} Response Status Codes:"
grep -oE ' [1-5][0-9]{2} ' nginx-log.txt | sort | uniq -c | sort -rn | awk '{print $2 " - " $1 " requests"}' |  head -n $COUNTS 

echo -e "\nTop ${COUNTS} User Agents:"
awk -F'"' '{print $6}' nginx-log.txt | sort | uniq -c | sort -nr | awk '{for(i=2;i<=NF;i++) printf "%s ", $i; print "-",$1,"requests"}' | head -n $COUNTS
