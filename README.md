# Network Connection Analyzer

A lightweight interactive Bash script for analyzing active network connections and displaying statistics directly from the terminal.

## Requirements

- Bash 4.0+
- Standard Linux utilities: `ss`, `awk`, `grep`, `sort`, `uniq`

## Installation

```bash
chmod +x netmonitor.sh
sudo ./netmonitor.sh
```

## Features

### 1. Live Connections View

Displays a real-time table of active network connections, auto-refreshed every 5 seconds.

| Column         | Description                           |
| -------------- | ------------------------------------- |
| Proto          | Protocol (`TCP` or `UDP`)             |
| Local Address  | Local IP address and port             |
| Remote Address | Remote IP address and port            |
| State          | Connection state (e.g. `ESTABLISHED`) |
| PID            | Process ID                            |
| Process        | Name of the process owning the socket |

Press `Ctrl+C` to stop the auto-refresh loop and exit.

### 2. Connection Statistics

Calculates and displays the total number of:

- TCP connections
- UDP connections
- Connections in the `ESTAB` (`ESTABLISHED`) state

### 3. Top Processes

Automatically parses process data to count and display the top 5 processes with the highest number of open connections.

## Usage Example

```bash
=== NETWORK CONNECTIONS ===

TCP connections: 123
UDP connections: 12
ESTABLISHED: 98

Proto  Local Address                         Remote Address                        State         PID    Process
---------------------------------------------------------------------------------------------------------------
udp    127.0.0.1:52345                       0.0.0.0:*                             UNCONN       1026   v2ray
tcp    [fd7a:115c:a1e0::2136:72b]:44983     [::]:*                                LISTEN        643   tailscaled
tcp    [::1]:34227                           [::]:*                                LISTEN       1026   v2ray
tcp    *:2017                                *:*                                   LISTEN        915   v2raya
...

Top processes:
1. v2ray — 82 connections
2. firefox — 15 connections
3. Telegram — 9 connections
4. tailscaled — 7 connections
5. next-server — 2 connections

------------------------------------------------------------
Updating in 5 seconds... (Press Ctrl+C to stop)
```

## Notes

- Running the script with `sudo` is highly recommended
- Without root privileges, the script may not be able to fetch PID and process names for sockets owned by other users or system services
