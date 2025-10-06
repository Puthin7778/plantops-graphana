
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

EXPOSE 8000

# Set default environment variables for Grafana connection
ENV GRAFANA_URL="http://localhost:3000"
ENV GRAFANA_SERVICE_ACCOUNT_TOKEN="dummy-token"

# Add health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8000/ || exit 1

CMD ["./mcp-grafana", "--transport", "sse", "--address", "0.0.0.0:8000", "--log-level", "debug"]
