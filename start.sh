#!/bin/sh

# Set minimal Grafana credentials for faster startup
export GRAFANA_URL="https://puthinkrishnamamidipalli.grafana.net"
export GRAFANA_SERVICE_ACCOUNT_TOKEN="glsa_""SaHDGNImNpXWQ39C6T0smIJlKFPb3SCy_""adf90756"
export GRAFANA_USERNAME="puthinkrishnamamidipalli"  
export GRAFANA_PASSWORD="plantops@123"

# Add timeout settings to prevent hanging
export GRAFANA_HTTP_TIMEOUT="5s"

# Start the MCP server
echo "Starting MCP server with credentials..."
echo "GRAFANA_URL: $GRAFANA_URL"
echo "GRAFANA_SERVICE_ACCOUNT_TOKEN: ${GRAFANA_SERVICE_ACCOUNT_TOKEN:0:20}..."
echo "Server starting on 0.0.0.0:8000"

# Start with streamable-http and minimal tool set
echo "Starting with streamable-http transport and minimal tools..."
./mcp-grafana \
  --transport streamable-http \
  --address 0.0.0.0:8000 \
  --endpoint-path / \
  --log-level debug \
  --debug \
  --disable-incident \
  --disable-oncall \
  --disable-asserts \
  --disable-sift \
  --disable-pyroscope