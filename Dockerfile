FROM ollama/ollama:latest

WORKDIR /opt/ollama

COPY download-models.sh .

RUN /bin/bash ./download-models.sh

RUN rm ./download-models.sh

ENV NVIDIA_VISIBLE_DEVICES=all
ENV OLLAMA_HOST="0.0.0.0"
EXPOSE 11434/tcp

ENTRYPOINT [ "/usr/bin/ollama" ]
CMD ["serve"]