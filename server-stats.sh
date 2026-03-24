#!/bin/bash

echo "===============Server Performance Stat's=================="
echo
echo "🔹 CPU Usage:"
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d. -f1)
#echo $CPU_IDLE
echo
CPU_USAGE=$((100 - CPU_IDLE))
echo "Total CPU Usage: $CPU_USAGE%"

echo

echo "🔹 Memory Usage:"
read TOTAL USED FREE <<< $(free -m | awk 'NR==2{print $2, $3, $4}')
MEM_PERCENT=$((USED * 100 / TOTAL))

echo "Total: ${TOTAL}MB"
echo "Used: ${USED}MB"
echo "Free: ${FREE}MB"
echo "Usage: ${MEM_PERCENT}%"
echo

echo "Disk Usage"

TOTAL_DISK=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')
DISK_PERCENT=$(df -h / | awk 'NR==2 {print $5}')


echo "TOTAL DISK UTILIZATIO $TOTAL_DISK"
echo "TOTAL FREE $DISK_FREE"
echo "TOTAL PERCENTAGE $DISK_PERCENT"

echo  "TOP 5 Processes by CPU Usage "

ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6

echo "TOP 5 Processes by Memory utilization "

ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6

# ---------------- EXTRA STATS ----------------
echo "🔹 Additional Stats:"

# OS Version
echo "OS Version:"
cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"'
echo

# Uptime
echo "Uptime:"
uptime -p
echo

# Load Average
echo "Load Average:"
uptime | awk -F'load average:' '{ print $2 }'
echo

# Logged-in Users
echo "Logged-in Users:"
who
echo

# Failed Login Attempts (Debian/Ubuntu systems)
if [ -f /var/log/auth.log ]; then
    echo
    echo "Recent Failed Login Attempts:"
    grep "Failed password" /var/log/auth.log | tail -5
fi

echo
echo "========================================================="


