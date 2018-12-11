FROM debian:sid
RUN apt-get update && apt-get install net-tools

COPY app.sh /app.sh

CMD ["sh"]
ENTRYPOINT ["/app.sh"]
