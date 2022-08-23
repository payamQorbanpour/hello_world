FROM golang:1.17-alpine AS build

ENV HTTPS_PROXY="http://fodev.org:8118"

WORKDIR /app

COPY . ./

RUN go mod download && GOOS=linux GOARCH=amd64 go build -o main && chmod +x ./main

FROM alpine:latest

RUN apk --no-cache add bash

WORKDIR /app

COPY --from=build /app/main .

CMD ["./main"]

EXPOSE 8000
