#!/bin/bash

echo "++++++++++++++++++++++++++++"
echo     "LINUX LOG MONITORING"
echo "++++++++++++++++++++++++++++"

echo ""
echo "Checking Apache Error Logs..."

if [ -f /var/log/apache2/error.log ]; then
    sudo tail -n 10 /var/log/apache2/access.log
else
    echo "Apache error log not found."
fi

echo ""
echo "Checking Recent System Logs..."

sudo journalctl -n 10 --no-pager

echo ""
echo "Log Monitoring Completed."
echo "============================"



