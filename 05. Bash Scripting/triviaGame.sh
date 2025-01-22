#!/bin/bash

#objective: create a trivia game that asks min. 5 questions to the user & keeps score of how many were answered correctly

echo "welcome to the trivia game! (LT edition)"
read -p "enter your name: " NAME

#initializing score
SCORE=0

#function to ask a question
ask_question() {
    local QUESTION=$1
    local CORRECT_ANSWER=$2

    #question is provided & user's answer is read
    echo -e "\n$QUESTION"
    read -p "your answer: " USER_ANSWER

    #check if the answer is correct
    if [[ "${USER_ANSWER,,}" == "${CORRECT_ANSWER,,}" ]]; then
        echo "correct!"
        ((SCORE++))
    else
        echo "wrong! the correct answer was: $CORRECT_ANSWER"
    fi
}

echo "please answer the following questions:"

# Questions and answers
ask_question "1. what is the capital of Lithuania?" "Vilnius"
ask_question "2. when did lithuania gain it's independence?" "1990"
ask_question "3. when was the name of Lithuania first mentioned?" "1009"
ask_question "4. who was the only Lithuanian king?" "Mindaugas"
ask_question "5. what sport is the most popular sport in Lithuania?" "basketball"

#display the final score
echo -e "\ngame over!"
echo "you scored $SCORE out of 5."
