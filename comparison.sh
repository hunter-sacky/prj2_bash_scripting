#!/bin/bash

#Creating the two strings to compare
string_a="UNIX"
string_b="GNU"

echo "Are $string_a and $string_b strings equal?"
#The below statement checks to see if they're equal
[ $string_a = $string_b ]
#The below statement prints out the equality output
echo $?

#Creating the two integers to compare
num_a=100
num_b=100

echo "Is $num_a equal to $num_b ?"
#The below statement checks to see if the two integers are equal
[ $num_a -eq $num_b ]
#The below statement prints out the equality output
echo $?
