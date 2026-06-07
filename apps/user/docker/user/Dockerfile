FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY . .

RUN rm -rf vendor

RUN go mod init github.com/microservices-demo/user || true
RUN go mod tidy || true

RUN CGO_ENABLED=0 GOOS=linux go build -mod=mod -a -installsuffix cgo -o user-app .

FROM alpine:3.19

RUN apk --no-cache add ca-certificates

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder --chown=appuser:appgroup /app/user-app .

USER appuser

EXPOSE 8084

CMD ["./user-app", "-port=8084"]