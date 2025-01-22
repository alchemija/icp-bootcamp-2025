#!/bin/bash

#objective: create a celsius/fahrenheit unit converter

# check if both arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <temperature> <C|F>"
    exit 1
fi

TEMP=$1
UNIT=${2^^} #converting to uppercase

# Validate the input and perform conversion
if [[ "$UNIT" == "C" ]]; then
    # c to f: F = (C * 9/5) + 32
    RESULT=$(( (TEMP * 9 / 5) + 32 ))
    echo "$TEMP°C is equal to $RESULT°F"
elif [[ "$UNIT" == "F" ]]; then
    # f to c: C = (F - 32) * 5/9
    RESULT=$(( (TEMP - 32) * 5 / 9 ))
    echo "$TEMP°F is equal to $RESULT°C"
else
    echo "error: invalid unit. use 'C' for celsius, 'F' for fahrenheit"
    exit 1
fi
