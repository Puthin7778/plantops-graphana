# Build stage
FROM golang:1.23-alpine AS builder

WORKDIR /app

# Copy go files
COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Build with static linking
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags '-s -w' -o mcp-grafana ./cmd/mcp-grafana

# Final stage - minimal image
FROM alpine:latest

RUN apk --no-cache add ca-certificates
WORKDIR /app

COPY --from=builder /app/mcp-grafana .

EXPOSE 8000

CMD ["./mcp-grafana", "--transport", "streamable-http", "--address", "0.0.0.0:8000"]
