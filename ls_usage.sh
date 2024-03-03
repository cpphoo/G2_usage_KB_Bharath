#!/bin/bash

if [[ -z "$1" ]]; then
    sacct -a -X --format=user%-7,jobid%8,jobname%10,State%10,partition%10,nodelist%20,AllocTRES%45,Start | (sed -u 2q; grep 'RUNNING\|PENDING\|REQUEUED') | (sed -u 2q; sort )
else
    sacct -a -X --format=user%-7,jobid%8,jobname%10,State%10,partition%10,nodelist%20,AllocTRES%45,Start | (sed -u 2q; grep 'RUNNING\|PENDING\|REQUEUED' | grep $1) | (sed -u 2q; sort)
fi
# ls -Art /share/nikola/export/g2_usage/sacct.$(date +"%m%d%Y")* | tail -n 1 | xargs cat | grep $1 | sort -k 1,1