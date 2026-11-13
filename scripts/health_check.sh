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

# RESOURCE HEALTH MONITORING

CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk -F',' '{for(i=1;i<=NF;i++) if($i ~ / id/) {gsub(/[^0-9.]/,"",$i); print $i}}')

CPU_USAGE=$(awk -v idle="$CPU_IDLE" 'BEGIN {printf "%.1f", 100-idle}')

RAM_USAGE=$(free | awk '/Mem:/ {printf "%.1f", ($2-$7)/$2*100}')

DISK_USAGE=$(df -P / | awk 'NR==2 {gsub(/%/,"",$5); print $5}')


{
echo "---------- RESOURCE HEALTH STATUS ----------"

# CPU CHECK

echo "CPU Usage: $CPU_USAGE%"

if awk -v usage="$CPU_USAGE" 'BEGIN {exit !(usage >= 80)}'; then
    echo "CPU Status: WARNING"
else
    echo "CPU Status: HEALTHY"
fi

# RAM CHECK

echo "RAM Usage: $RAM_USAGE%"

if awk -v usage="$RAM_USAGE" 'BEGIN {exit !(usage >= 80)}'; then
    echo "RAM Status: WARNING"
else
    echo "RAM Status: HEALTHY"
fi

# DISK CHECK

echo "Disk Usage: $DISK_USAGE%"

if [ "$DISK_USAGE" -ge 80 ]; then
    echo "Disk Status: WARNING"
else
    echo "Disk Status: HEALTHY"
fi

echo ""

} >> "$REPORT_FILE"


# OVERALL RESOURCE STATUS

{
echo "---------- OVERALL RESOURCE STATUS ----------"

if awk -v cpu="$CPU_USAGE" -v ram="$RAM_USAGE" -v disk="$DISK_USAGE" \
'BEGIN {exit !(cpu >= 80 || ram >= 80 || disk >= 80)}'
then
    echo "Overall Resource Status: WARNING"
else
    echo "Overall Resource Status: HEALTHY"
fi

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
