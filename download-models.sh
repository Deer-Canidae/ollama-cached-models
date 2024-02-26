#!/bin/bash

echo "starting ollama"
ollama start < /dev/null > /dev/null 2>&1 &
OLLAMA_PID=$!
sleep 1s

#For general uses
ollama pull mistral:instruct
MISTRAL_RETURN_CODE=$?

if [ "$MISTRAL_RETURN_CODE" -ne "0" ] ; then
    echo "Mistral failed to pull. Exiting."
    kill $OLLAMA_PID
    wait
    exit 1
fi

#For use with coder-llama
ollama pull stable-code:3b-code-q4_0
STABLE_CODE_RETURN_CODE=$?

if [ "$STABLE_CODE_RETURN_CODE" -ne "0" ] ; then
    echo "Stable code failed to pull. Exiting."
    kill $OLLAMA_PID
    wait
    exit 1
fi

kill $OLLAMA_PID
wait
exit 0