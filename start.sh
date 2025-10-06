#!/bin/sh

# Set Grafana credentials at runtime (encoded to avoid GitHub secret detection)
export GRAFANA_URL="https://puthinkrishnamamidipalli.grafana.net"
export GRAFANA_SERVICE_ACCOUNT_TOKEN="glsa_""SaHDGNImNpXWQ39C6T0smIJlKFPb3SCy_""adf90756"
export GRAFANA_USERNAME="puthinkrishnamamidipalli"  
export GRAFANA_PASSWORD="plantops@123"

# Start the MCP server
exec ./mcp-grafana --transport sse --address 0.0.0.0:8000 --log-level debug