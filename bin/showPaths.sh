#!/bin/bash

VAL=1
while [ `echo $PATH"$" | cut -c$VAL` != "$" ]; do
	if [ `echo $PATH | cut -c$VAL` = ":" ]; then 
		echo 
	else 
		echo -n `echo $PATH | cut -c$VAL`
	fi
	VAL=$(($VAL+1))
done
echo 
