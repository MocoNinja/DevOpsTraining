FROM golang:alpine
RUN mkdir /app
COPY web.go /app/web.go
WORKDIR /app
RUN go build -o main .
CMD ["/app/main"]
