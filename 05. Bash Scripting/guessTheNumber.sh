#!/bin/bash

#check if both arguments are provided
if [ "$#" -ne 2 ]; then
  echo "usage: $0 <num1> <num2>"
  exit 1
fi

#calculating the result
RESULT=$(( $1 * $2 - 1 ))

#nulling numguess
NUMGUESS=

#loop will run until user's guess is equal to the result
while [[ $NUMGUESS -ne $RESULT ]]; do
    #getting user input
    read -p "enter your guess: " NUMGUESS

    #checking comparison
    if [[ $NUMGUESS -gt $RESULT ]]; then
        echo "too big!"
    elif [[ $NUMGUESS -lt $RESULT ]]; then
        echo "too small!"
    fi
done

echo "you win!"


