#!/bin/sh

lignes=$(df -h |wc -l)
memoire_libre=0


for i in `seq 3 $((lignes))`

do
 $memoire_libre=$memoire_libre + $(df | awk '{print $4}' | awk -v l=$i 'NR==l{ print }')
done

memoire_libre_giga=$memoire_libre/(1024*1024)

echo "max=$memoire_libre_giga" 
