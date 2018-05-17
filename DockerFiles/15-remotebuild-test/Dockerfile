FROM ubuntu:xenial

RUN apt update && apt install -y figlet

ADD ./entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "JAVIER" ]
