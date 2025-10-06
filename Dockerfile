
FROM golang:alpine AS builder

WORKDIR /app

# Copy go files
COPY go.mod go.sum ./
RUN go mod download

COPY . .


RUN CGO_ENABLED=0 GOOS=linux go build -ldflags '-s -w' -o mcp-grafana ./cmd/mcp-grafana


FROM alpine:latest

RUN apk --no-cache add ca-certificates
WORKDIR /app

COPY --from=builder /app/mcp-grafana .

EXPOSE 8000

# Set environment variables for Grafana connection (will need to be configured in Smithery)
ENV GRAFANA_URL=""
ENV GRAFANA_SERVICE_ACCOUNT_TOKEN=""

CMD ["./mcp-grafana", "--transport", "streamable-http", "--address", "0.0.0.0:8000", "--endpoint-path", "/", "--log-level", "debug"]
