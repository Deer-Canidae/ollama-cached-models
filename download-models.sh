#!/bin/bash

echo "starting ollama"
ollama start < /dev/null > /dev/null 2>&1 &
OLLAMA_PID=$!
sleep 1s

#Quick gracefully with return code
quit() {
    kill $OLLAMA_PID
    wait
    exit $1
}

#Pull specified model
pull() {
    ollama pull $1
    RETURN_CODE=$?
    if [ $RETURN_CODE -ne "0" ]; then
        echo "$1 failed to pull"
        quit 1
    fi
}

#For use with coder-llama
ollama pull stable-code:3b-code-q4_0

#For general uses
pull mistral:instruct

#Experimenting with dolphin-mistral
pull dolphin-mistral:latest

#Quit successfully
quit 0
