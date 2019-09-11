
#build stage
FROM golang:alpine AS builder
WORKDIR /go/src/app
COPY . .
RUN apk add --no-cache git
RUN go build

#final stage
FROM alpine:latest
RUN apk --no-cache add ca-certificates
ENV GIN_MODE=release
COPY --from=builder /go/src/app/cfeu19-sample-app /app
COPY --from=builder /go/src/app/templates /templates
ENTRYPOINT ./app
EXPOSE 3000
