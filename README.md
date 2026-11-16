# Linux Log Analyzer

A Bash-based Linux log analysis tool designed to inspect system and authentication logs.

The script extracts useful information from Linux log files, including error messages, session activity, sudo-related entries, authentication failures, and SSH login attempts.

## Project Goals

- Practice Bash scripting and Linux command-line tools.
- Understand Linux authentication and system logs.
- Analyze security-related events.
- Build a practical Linux administration and monitoring project.

## Features

The analyzer supports:

- **Log Statistics:** Total number of log lines, INFO messages, warnings, and errors.
- **Frequent Errors:** Extracts and ranks the five most frequent named errors matching the expected log format.
- **Session Monitoring:** Counts opened and closed sessions.
- **Sudo Activity:** Counts log entries containing `sudo`.
- **Authentication Monitoring:** Identifies authentication failures and groups them by username.
- **SSH Security Monitoring:**
  - Failed SSH password attempts grouped by source IP.
  - Successful SSH password logins grouped by source IP.
- **Service Analysis:** Breaks down opened and closed sessions by service.
- **Privilege Monitoring:** Counts logged `pkexec` command executions.
- **Input Validation:** Accepts a custom log-file path and checks whether the file exists.

## Requirements

- Linux operating system
- Bash
- Standard Linux command-line utilities:
  - grep
  - awk
  - sed
  - sort
  - uniq
  - head
  - wc

## Installation

Clone the repository:

```bash
git clone https://github.com/Amin238/Linux-log-analyzer.git
```

Navigate into the project directory:

```bash
cd Linux-log-analyzer
```

Make the script executable:

```bash
chmod +x log_analyzer.sh
```

## Usage

Run the analyzer with the default authentication log:

```bash
./log_analyzer.sh
```

Analyze a specific log file:

```bash
./log_analyzer.sh /var/log/auth.log.1
```

Analyze the system log:

```bash
./log_analyzer.sh /var/log/syslog
```

If the specified file does not exist, the script displays an error message and exits.

## Example Output

Example results when analyzing `/var/log/auth.log.1`:

```text
Total log lines: 1786
INFO messages: 1
Warning messages: 0
Number of errors: 25

Authentication failures:
11 amin

SSH failed password attempts:
4 127.0.0.1
1 192.168.1.8

Successful SSH logins by IP:
2 192.168.1.8
1 127.0.0.1

Privilege monitoring (pkexec):
33
```

## Limitations

- Error extraction depends on the specific log format used by the script.
- SSH monitoring currently detects password authentication attempts, not public-key authentication.
- Sudo activity counts log entries containing `sudo`; it does not distinguish successful and failed commands.
- Session statistics count log entries, not necessarily unique user sessions.
- Results depend on the log file format and available log data.
