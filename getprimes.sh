#!/bin/bash

# Initiation for low and upper values
flag1=0 # Flag number 1 to be used in first validation user input
flag2=0 # Flag number 2 to be used in second validation user input
total=0 # Value used to sum all the prime numbers
declare -a rangeArray # Array created to show values between minimum and maximum ranges

# First validation user input
while [ $flag1 -eq  0 ] # Cycle to validate integer numbers in lower value
do
    read -p "$(tput setaf 7)Range start : " lvalue # Prompt the user for lower value white color message
    if ! [[ $lvalue =~ ^[0-9]+$ ]] || [ $lvalue -eq 0 ] || [ $lvalue -eq 1 ]; # Checking if the lower value is not an integer, string, or null
        then
            echo " $(tput setaf 1)Invalid start range value. Start range must be an integer greater than 1. Please try again." # Warning red message prompt for re entering integer
    else # Because value is an integer lower, inititation variable changes and ends while cycle
        flag1=1 
    fi # Closing if steatment
done # Ending while cycle

#Second validation user input
while [ $flag2 -eq  0 ] # Cycle to validate integer numbers in upper value
do
    read -p "$(tput setaf 7)Range end : " uvalue # Prompt the user for upper value white color message
    if ! [[ $uvalue =~ ^[0-9]+$ ]] || [ $uvalue -eq 0 ] || [ $uvalue -eq 1 ]; # Checking if the lower value is not an integer, string, or null
        then
            echo "$(tput setaf 1)Invalid start range value. Start range must be an integer greater than 1. Please try again." # Warning red message prompt for re entering integer
    elif ! [ $lvalue -lt $uvalue ]; # Ensures the lower range bound provided is more than the lower range bound provided
        then
        echo "$(tput setaf 1)Invalid start range value. Start range must be an integer and at least 2 digits greater than the start range. Please try again."
    else # Checking if the difference between ranges is not greater than 1
        diff=$(($uvalue-$lvalue))
        if ! [ $diff -gt 1 ];
            then
            echo "$(tput setaf 1)Invalid start range value. Start range must be an integer and at least 2 digits greater than the start range. Please try again."
        else # Because value is an integer upper, and the difference is at least one number, inititation variable changes and ends while cycle
            flag2=1
        fi # Closing if steatment
    fi # Closing if steatment
done # Ending while cycle

printf "\nYou have selected the range $lvalue - $uvalue\n" # Checking lower and upper values in memory

# Filling array with values between min and max ranges  with C loop style
for (( i=$lvalue; i<=$uvalue; i++ ))
do
    rangeArray+=($i)
done # Ending c for cycle

# For cycle to check if the number is prime or not in the array
for i in "${rangeArray[@]}";
do
    for (( y=2; y<=$i/2; y++ )) # Looping values in array from two to less and equal to value dividing it by 2
    do
        reminder=$(( i%y )) # Setting reminder depending of the division between the value and 2
        if [ $reminder -eq 0 ] # If reminder is equal to zero the value is not a prime number
        then
            #Because the value is not a prime number it need to be removed from the array
            for x in "${!rangeArray[@]}"; # Looping through array indices or keys to compare and unset no prime number index
            do
                if [[ ${rangeArray[x]} = $i ]]; # If key in array is equal to key of no prime number
                then
                unset 'rangeArray[x]' # Whole element in array will be removed
                fi # Closing if steatment
            done  # Ending for cycle
            break # The condition has been met, it will break the c for cycle
        fi # Closing if steatment
    done # Ending c for cycle
done # Ending for cycle

# For cycle to sum up each element of the array
for i in "${rangeArray[@]}";
do
    let total+=$i # Sum total with each prime number in the array
done # Ending for cycle

# Condition to check if there are no prime number in the range
if [[ ${#rangeArray[@]} = 0 ]]; # If the array is empty
then
    printf "\nNo prime number(s) exist withing the range $lvalue and $uvalue\n" # Print message with no prime numbers
else # Because array has prime values it follows to print 
    printf "\n${#rangeArray[@]} prime number(s) were found between $lvalue and $uvalue, these being:\n" # Print message with ranges
    printf "\n[${rangeArray[*]}]\n" # Print message with prime numbers
    printf "\nThe sum of these prime numbers is $total\n" # Print message with the total sum of prime numbers
fi # Closing if steatment

exit 0 # Ending Shell Script