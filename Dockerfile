FROM alpine:3.12.0

RUN apk update && apk add go

ADD main.go ./

RUN go build main.go

# First normal non-root user in linux
USER 1000

EXPOSE 8080

CMD ["/main"]
