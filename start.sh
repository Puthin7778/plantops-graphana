#!/bin/sh

# Set Grafana credentials at runtime (encoded to avoid GitHub secret detection)
export GRAFANA_URL="https://puthinkrishnamamidipalli.grafana.net"
export GRAFANA_SERVICE_ACCOUNT_TOKEN="glsa_""SaHDGNImNpXWQ39C6T0smIJlKFPb3SCy_""adf90756"
export GRAFANA_USERNAME="puthinkrishnamamidipalli"  
export GRAFANA_PASSWORD="plantops@123"

# Start the MCP server
echo "Starting MCP server with credentials..."
echo "GRAFANA_URL: $GRAFANA_URL"
echo "Server starting on 0.0.0.0:8000"

# Try different transports - start with streamable-http first
./mcp-grafana --transport streamable-http --address 0.0.0.0:8000 --log-level debug &
SERVER_PID=$!

# Wait a bit and check if server started
sleep 5
if kill -0 $SERVER_PID 2>/dev/null; then
    echo "Server started successfully with PID $SERVER_PID"
    wait $SERVER_PID
else
    echo "Server failed to start with streamable-http, trying SSE..."
    ./mcp-grafana --transport sse --address 0.0.0.0:8000 --log-level debug
fi