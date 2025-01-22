#!/bin/bash

#objective: create a script that counts how many times a word appears in a text file


# check if both arguments are provided
if [ "$#" -ne 2 ]; then
    echo "usage: $0 <word> <file>"
    exit 1
fi

WORD=$1
FILE=$2

# check if the file exists
if [ -f "$FILE" ]; then
    # count occurrences of the word using grep
    COUNT=$(grep -o -w "$WORD" "$FILE" | wc -l)
    echo "the word '$WORD' appears $COUNT times in the file '$FILE'."
else
    echo "error: file '$FILE' does not exist."
    exit 1
fi
