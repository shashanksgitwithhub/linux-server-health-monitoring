#!/bin/bash

# Linux Server Health Monitoring System

PROJECT_DIR="$HOME/linux-server-health-monitoring"
REPORT_DIR="$PROJECT_DIR/reports"
LOG_DIR="$PROJECT_DIR/logs"

REPORT_FILE="$REPORT_DIR/server_health_report.txt"
LOG_FILE="$LOG_DIR/health_check.log"

HOSTNAME=$(hostname)
CURRENT_DATE=$(date)

{
echo "========================================="
echo "     LINUX SERVER HEALTH MONITORING"
echo "========================================="

echo "Hostname: $HOSTNAME"
echo "Date: $CURRENT_DATE"

echo "========================================="
echo ""
} > "$REPORT_FILE"

{
echo "------------ CPU INFORMATION ------------"

echo "CPU Count: $(nproc)"

echo "System Load:"
uptime

echo ""
} >> "$REPORT_FILE"

{
echo "---------- MEMORY INFORMATION -----------"

free -h 

echo ""
} >> "$REPORT_FILE"

{
echo "----------- DISK UTILIZATION ------------"

df -h /

echo ""
} >> "$REPORT_FILE"

{
echo "----------- SERVICE STATUS --------------"

if systemctl is-active --quiet ssh; then
     echo "SSH Service: RUNNING"
else
     echo "SSH Service: NOT RUNNING"
fi

if systemctl is-active --quiet apache2; then
     echo "Apache Service: RUNNING"
else
     echo "Apache Service: NOT RUNNING"
fi

echo ""
} >> "$REPORT_FILE"

{
echo "--------- RECENT SYSTEM LOGS ------------"

journalctl -n 10 --no-pager 2>/dev/null

echo ""
} >> "$REPORT_FILE"

{
echo "========================================="
echo "         HEALTH CHECK COMPLETED"
echo "========================================="
} >> "$REPORT_FILE"

echo "Health check executed at: $(date)" >> "$LOG_FILE"

echo "Health report generated successfully!"
echo "Report location: $REPORT_FILE"
