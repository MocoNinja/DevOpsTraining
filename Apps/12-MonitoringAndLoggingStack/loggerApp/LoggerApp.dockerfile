FROM ubuntu:xenial

RUN apt update && apt install -y net-tools

ADD application.sh /

ENTRYPOINT [ "/application.sh" ]

CMD [ "sh -c" ]
