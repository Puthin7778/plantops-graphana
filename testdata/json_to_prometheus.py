#!/usr/bin/env python3
"""
Convert sample JSON metrics to Prometheus format
This script reads the sample_metrics.json file and outputs Prometheus metrics
"""

import json
import sys
from datetime import datetime
import time

def convert_timestamp_to_unix(timestamp_str):
    """Convert ISO timestamp to Unix timestamp"""
    dt = datetime.fromisoformat(timestamp_str.replace('Z', '+00:00'))
    return int(dt.timestamp())

def output_prometheus_metrics(data):
    """Convert JSON data to Prometheus metrics format"""
    print("# HELP web_response_time_ms Response time in milliseconds")
    print("# TYPE web_response_time_ms gauge")
    
    for metric in data['metrics']['web_application']['response_time_ms']:
        timestamp = convert_timestamp_to_unix(metric['timestamp'])
        print(f"web_response_time_ms{{endpoint=\"{metric['endpoint']}\"}} {metric['value']} {timestamp}000")
    
    print("\n# HELP web_request_count Total number of requests")
    print("# TYPE web_request_count counter")
    
    for metric in data['metrics']['web_application']['request_count']:
        timestamp = convert_timestamp_to_unix(metric['timestamp'])
        print(f"web_request_count{{endpoint=\"{metric['endpoint']}\",status=\"{metric['status']}\"}} {metric['value']} {timestamp}000")
    
    print("\n# HELP web_cpu_usage_percent CPU usage percentage")
    print("# TYPE web_cpu_usage_percent gauge")
    
    for metric in data['metrics']['web_application']['cpu_usage_percent']:
        timestamp = convert_timestamp_to_unix(metric['timestamp'])
        print(f"web_cpu_usage_percent{{instance=\"{metric['instance']}\"}} {metric['value']} {timestamp}000")
    
    print("\n# HELP web_memory_usage_mb Memory usage in megabytes")
    print("# TYPE web_memory_usage_mb gauge")
    
    for metric in data['metrics']['web_application']['memory_usage_mb']:
        timestamp = convert_timestamp_to_unix(metric['timestamp'])
        print(f"web_memory_usage_mb{{instance=\"{metric['instance']}\"}} {metric['value']} {timestamp}000")
    
    print("\n# HELP web_error_rate_percent Error rate percentage")
    print("# TYPE web_error_rate_percent gauge")
    
    for metric in data['metrics']['web_application']['error_rate_percent']:
        timestamp = convert_timestamp_to_unix(metric['timestamp'])
        print(f"web_error_rate_percent{{endpoint=\"{metric['endpoint']}\"}} {metric['value']} {timestamp}000")

def main():
    try:
        with open('testdata/sample_metrics.json', 'r') as f:
            data = json.load(f)
        
        output_prometheus_metrics(data)
        
    except FileNotFoundError:
        print("Error: sample_metrics.json not found", file=sys.stderr)
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"Error parsing JSON: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
