#!/bin/bash
num_a=100
num_b=200

#Checks to see if a is less than b. Else statement executes when a==b or a is greater than b
if [  $num_a -lt $num_b ]; then
	echo "$num_a is less than $num_b!"
else
	echo "$num_a is greater than $num_b!"
fi
