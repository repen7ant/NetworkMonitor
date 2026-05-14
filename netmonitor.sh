#!/bin/bash

# 1. Fetch raw data.
RAW_DATA=$(sudo ss -tunapH)

# 2. Calculate statistics.
TCP_COUNT=$(echo "$RAW_DATA" | grep -c "^tcp")
UDP_COUNT=$(echo "$RAW_DATA" | grep -c "^udp")
ESTAB_COUNT=$(echo "$RAW_DATA" | grep -c "ESTAB")

# 3. Print the header and statistics
echo "=== NETWORK CONNECTIONS ==="
echo ""
echo "TCP connections: $TCP_COUNT"
echo "UDP connections: $UDP_COUNT"
echo "ESTABLISHED: $ESTAB_COUNT"
echo ""

# 4. Print the table header (formatting matches awk output)
printf "%-6s %-25s %-25s %-12s %-6s %s\n" "Proto" "Local Address" "Remote Address" "State" "PID" "Process"

# 5. Parse and print the connections
echo "$RAW_DATA" | awk '{
    proto = $1
    state = $2
    local_addr = $5
    remote_addr = $6
    
    pid = "-"
    proc_name = "-"
    
    if ($7 ~ /users:/) {
        split($7, a, "\"")
        proc_name = a[2]
        
        split($7, b, "pid=")
        split(b[2], c, ",")
        pid = c[1]
    }
    
    printf "%-6s %-25s %-25s %-12s %-6s %s\n", proto, local_addr, remote_addr, state, pid, proc_name
}'
