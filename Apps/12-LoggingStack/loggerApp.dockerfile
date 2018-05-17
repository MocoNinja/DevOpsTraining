FROM ubuntu:xenial

RUN apt update && apt install -y net-tools

COPY ./app/loggerApp.sh /logger.sh

ENTRYPOINT ["/logger.sh"]
CMD ["sh -c"]

