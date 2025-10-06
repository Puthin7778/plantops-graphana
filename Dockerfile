
FROM golang:alpine AS builder

WORKDIR /app

# Copy go files
COPY go.mod go.sum ./
RUN go mod download

COPY . .


RUN CGO_ENABLED=0 GOOS=linux go build -ldflags '-s -w' -o mcp-grafana ./cmd/mcp-grafana


FROM alpine:latest

RUN apk --no-cache add ca-certificates wget
WORKDIR /app

COPY --from=builder /app/mcp-grafana .
COPY start.sh .

RUN chmod +x start.sh

EXPOSE 8000

# Add health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8000/ || exit 1

CMD ["./start.sh"]
