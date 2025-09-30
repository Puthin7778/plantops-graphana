# Sample JSON Data and Grafana Dashboard

This directory contains sample JSON data and a corresponding Grafana dashboard for web application monitoring.

## Files

- `sample_metrics.json` - Sample JSON data containing web application metrics
- `web_app_monitoring.json` - Grafana dashboard configuration
- `json_to_prometheus.py` - Python script to convert JSON to Prometheus metrics format
- `prometheus-sample.yml` - Sample Prometheus configuration

## Sample Data Structure

The `sample_metrics.json` file contains realistic web application metrics including:

- **Response Time**: API endpoint response times in milliseconds
- **Request Count**: Number of requests by endpoint and status code
- **CPU Usage**: CPU utilization percentage by server instance
- **Memory Usage**: Memory consumption in MB by server instance
- **Error Rate**: Error percentage by endpoint

## Dashboard Features

The Grafana dashboard (`web_app_monitoring.json`) includes:

1. **API Response Time by Endpoint** - Time series showing response times for different API endpoints
2. **Request Rate by Status** - Stacked chart showing successful vs error requests
3. **CPU Usage by Instance** - CPU utilization across server instances
4. **Memory Usage by Instance** - Memory consumption across server instances
5. **Error Rate by Endpoint** - Error rates for different API endpoints

## Dashboard Variables

The dashboard includes template variables for filtering:

- **Endpoint**: Filter by specific API endpoints
- **Instance**: Filter by server instances

## How to Use

### Option 1: Direct JSON Import

1. Import the `web_app_monitoring.json` dashboard into Grafana
2. Configure a Prometheus datasource
3. The dashboard will work with any Prometheus data that matches the metric names

### Option 2: Convert JSON to Prometheus Metrics

1. Run the conversion script:
   ```bash
   python testdata/json_to_prometheus.py > metrics.txt
   ```
2. Import the metrics into Prometheus
3. Import the dashboard into Grafana
4. Configure the Prometheus datasource

### Option 3: Use with Docker Compose

1. Use the existing `docker-compose.yaml` in the project root
2. The dashboard will be automatically provisioned
3. Access Grafana at `http://localhost:3000`

## Metric Names

The dashboard expects these Prometheus metric names:

- `web_response_time_ms{endpoint, status}`
- `web_request_count{endpoint, status}`
- `web_cpu_usage_percent{instance}`
- `web_memory_usage_mb{instance}`
- `web_error_rate_percent{endpoint}`

## Customization

You can modify the sample JSON data to include:

- Additional endpoints
- More server instances
- Different time ranges
- Additional metric types

The dashboard will automatically adapt to the available data based on the metric labels.
