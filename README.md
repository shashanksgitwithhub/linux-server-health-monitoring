# Linux Server Health Monitoring and Automation

A Bash-based Linux server monitoring solution that automates CPU, memory, disk utilization, service availability checks, and system log collection. Uses Cron to schedule periodic health checks and generate server health reports.

## Project Overview

System administrators need to regularly monitor Linux servers to ensure that system resources and critical services are operating properly.

Performing these checks manually is repetitive and time-consuming.

This project automates routine Linux server health checks using Bash scripting and Cron. It collects system information, evaluates resource utilization against predefined thresholds, checks critical services, and generates consolidated health reports.

## Real-World Problem

In production environments, Linux administrators need to monitor:

- CPU utilization and system load.
- Memory consumption.
- Disk space availability.
- Critical services such as SSH and Apache.
- System logs for troubleshooting.

Manually performing these checks regularly can consume time and delay the identification of potential resource problems.

## Solution

Developed an automated monitoring solution that:

- Collects CPU, memory, and disk utilization.
- Identifies resource usage exceeding predefined thresholds.
- Checks SSH and Apache service availability.
- Collects recent system journal entries.
- Generates consolidated server health reports.
- Uses Cron to execute monitoring automatically every five minutes.

## Key Features

- **CPU Monitoring:** Collects CPU information and calculates CPU utilization.
- **Memory Monitoring:** Monitors RAM utilization and available memory.
- **Disk Monitoring:** Checks filesystem utilization and available storage.
- **Threshold Detection:** Identifies CPU, RAM, and disk utilization reaching 80% or higher.
- **Service Monitoring:** Checks whether SSH and Apache services are running.
- **Log Monitoring:** Collects recent system journal entries.
- **Automated Reporting:** Generates a consolidated server health report.
- **Cron Automation:** Executes scheduled health checks every five minutes.

## Technologies and Tools

| Technology | Purpose |
|---|---|
| Ubuntu Linux | Operating system |
| Bash Scripting | Monitoring automation |
| Cron | Scheduled execution |
| Git | Version control |
| GitHub | Source code hosting |
| Linux Commands | System administration |
| systemctl | Service monitoring |
| journalctl | System log collection |
| awk | Data extraction and calculations |

## Project Architecture

```text
             Ubuntu Linux Server
                      |
                      v
                Cron Scheduler
                      |
                Every 5 Minutes
                      |
                      v
                health_check.sh
                      |
          ---------------------------
          |            |            |
          v            v            v
         CPU           RAM         Disk
          |            |            |
          ---------------------------
                      |
                      v
             Threshold Detection
                      |
                      v
              Service Monitoring
                      |
                 -----------
                 |         |
                 v         v
                SSH      Apache
                 |         |
                 -----------
                      |
                      v
               System Log Check
                      |
                      v
              Generate Health Report
                      |
                 -----------
                 |         |
                 v         v
               Reports    Logs
```

## Project Directory Structure

```text
linux-server-health-monitoring/
│
├── documentation/
│
├── logs/
│   └── health_check.log
│
├── reports/
│   ├── server_health_report.txt
│   └── system_report.txt
│
├── screenshots/
│
├── scripts/
│   ├── health_check.sh
│   ├── health_check_backup.sh
│   ├── apache2_service_check.sh
│   ├── disk_check.sh
│   ├── log_monitor.sh
│   ├── cron_test.sh
│   ├── hello.sh
│   └── variables.sh
│
└── .gitignore
```

Note: Generated `.log` files are excluded from Git using `.gitignore`. The backup and practice scripts are retained for reference; `health_check.sh` is the primary monitoring script.

## Monitoring Thresholds

The project uses predefined thresholds to identify potential resource issues.

| Resource | Healthy | Warning |
|---|---|---|
| CPU Usage | Below 80% | 80% or higher |
| RAM Usage | Below 80% | 80% or higher |
| Disk Usage | Below 80% | 80% or higher |

If any monitored resource reaches the warning threshold, the overall resource status is reported as WARNING.

Otherwise, the overall resource status is reported as HEALTHY.

These thresholds are configurable within the Bash script.

## Installation and Configuration

### 1. Clone the Repository

```bash
git clone https://github.com/shashanksgitwithhub/linux-server-health-monitoring.git
```

### 2. Navigate to the Project Directory

```bash
cd linux-server-health-monitoring
```

### 3. Install Required Packages

```bash
sudo apt update
sudo apt install apache2 cron -y
```

### 4. Make the Main Script Executable

```bash
chmod +x scripts/health_check.sh
```

### 5. Execute the Health Monitoring Script

```bash
./scripts/health_check.sh
```

The script generates a health report inside the `reports/` directory.

## Cron Automation

Cron is configured to execute the monitoring script automatically every five minutes.

Open the crontab:

```bash
crontab -e
```

Add the following entry, replacing the path with your actual project location:

```bash
*/5 * * * * /home/your-user/linux-server-health-monitoring/scripts/health_check.sh
```

Verify the scheduled job:

```bash
crontab -l
```

Check the execution history:

```bash
cat logs/health_check.log
```

## Sample Health Report

Example output:

```text
========================================
      LINUX SERVER HEALTH MONITORING
========================================

Hostname: ubuntuserver

---------- CPU INFORMATION ----------

CPU Count: 1
System Load: 0.08, 0.04, 0.05

---------- MEMORY INFORMATION ----------

Total RAM: 1.9Gi
Available RAM: 1.6Gi

---------- DISK UTILIZATION ----------

Disk Usage: 51%

---------- RESOURCE HEALTH STATUS ----------

CPU Usage: 75.0%
CPU Status: HEALTHY

RAM Usage: 15.9%
RAM Status: HEALTHY

Disk Usage: 51%
Disk Status: HEALTHY

---------- OVERALL RESOURCE STATUS ----------

Overall Resource Status: HEALTHY

---------- SERVICE STATUS ----------

SSH Service: RUNNING
Apache Service: RUNNING

---------- RECENT SYSTEM LOGS ----------

Recent system journal entries...

========================================
          HEALTH CHECK COMPLETED
========================================
```

*Sample values are illustrative and will vary depending on the server.*

## Skills and Concepts Learned

- Linux system administration.
- Bash scripting and automation.
- Linux process and resource monitoring.
- CPU, RAM, and disk utilization.
- Linux service management using systemctl.
- System log analysis using journalctl.
- Conditional statements and variables in Bash.
- Cron scheduling and automation.
- Git and GitHub version control.
- Troubleshooting Linux scripts.

## Future Improvements

Potential enhancements for future versions:

- Email notifications for critical resource usage.
- Automated service recovery.
- Historical resource utilization tracking.
- Integration with AWS CloudWatch.
- Centralized monitoring dashboard.

## Author

**Shashank TJ**

GitHub: https://github.com/shashanksgitwithhub

Project Repository: https://github.com/shashanksgitwithhub/linux-server-health-monitoring

---

**Project:** Linux Server Health Monitoring and Automation

**Category:** Linux System Administration / Automation

**Status:** Completed
