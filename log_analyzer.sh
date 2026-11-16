#!/bin/bash
         
LOG_FILE="${1:-/var/log/auth.log}"
echo "Log file : $LOG_FILE"
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: Log file not found."
    exit 1
fi

echo "           LINUX LOG ANALYZER           "



echo "TOP 5 MOST FREQUENT ERRORS"
grep -i "error" "$LOG_FILE" | grep -ioE 'error name="[^"]+"'| sort | uniq -c | sort -nr | head -5 | sed 's/error name="//; s/"$//' 



echo "Total log  lines :"
wc -l "$LOG_FILE" | awk '{print$1}' 

echo "INFO messages :"
grep -ci "INFO" "$LOG_FILE"
echo "warning messages: "
grep -ci "warning" "$LOG_FILE"
echo  "number of errors :"
grep -ci "error" "$LOG_FILE"


  

echo "opened session"
if grep -qi "session opened" "$LOG_FILE"; then   grep -ci "session opened" "$LOG_FILE" ; else   echo  "no opened session found"; fi
 
echo "closed session"
if grep -qi "session closed" "$LOG_FILE"; then   grep -ci "session closed" "$LOG_FILE" ; else   echo  "no closed session found"; fi

echo "lines with sudo"
if grep -qi "sudo" "$LOG_FILE"; then   grep -ci "sudo" "$LOG_FILE" ; else   echo  "no sudo entrance session found"; fi

echo "authentication failure"
if grep -qi "authentication failure" "$LOG_FILE";then grep -i "authentication failure" "$LOG_FILE" | awk '{for (i=1;i<=NF;i++) if($i ~ /^user=/) print $i}' | cut -d = -f 2 | sort | uniq -c; else   echo  "no authentication  found"; fi
echo "ssh failed password "
if grep -qi 'sshd\[.*Failed password for' "$LOG_FILE"; then grep -i 'sshd\[.*Failed password for' "$LOG_FILE" | awk '{for (i=1;i<=NF;i++) if($i == "from") print $(i+1)}' | sort | uniq -c | sort -nr ; else  echo  "no ssh failed password found"; fi
echo "successful SSH logins by IP"
if grep -qi 'sshd\[.*Accepted password for' "$LOG_FILE"; then
    grep -i 'sshd\[' "$LOG_FILE" | grep -i 'Accepted password for' |
    awk '{for (i=1;i<=NF;i++) if($i == "from") print $(i+1)}' |
    sort | uniq -c | sort -nr
else
    echo "no successful SSH password logins found"
fi

echo "opened sessions by service"
if grep -qi "session opened" "$LOG_FILE"; then grep -i "session opened" "$LOG_FILE" | awk -F'pam_unix\\(' '{print $2}' | cut -d: -f1 | sort | uniq -c ; else echo "no opened session  found "; fi
echo "closed sessions by service"
if grep -qi "session closed" "$LOG_FILE"; then grep -i "session closed" "$LOG_FILE" | awk -F'pam_unix\\(' '{print $2}' | cut -d: -f1 | sort | uniq -c; else echo "no closed session found"; fi
echo "count privileged(root permission) commands executed through pkexec"
if grep -qi "pkexec.*Executing command" "$LOG_FILE"; then grep -ci 'pkexec.*Executing command' "$LOG_FILE"; else echo "no privileged entrance excuted through pkexec  found"; fi

