#!/bin/bash

# This script demonstrates a race condition where two processes try to update a shared file.
# This can lead to unexpected or corrupted results.

file="shared_file.txt"
echo "Initial value" > "$file"

process1() {
  while true; do
    value=`cat "$file"`
    new_value=$((value + 1))
    echo "Process 1: Updating from $value to $new_value"
    echo $new_value > "$file"
    sleep 0.1
  done
}

process2() {
  while true; do
    value=`cat "$file"`
    new_value=$((value * 2))
    echo "Process 2: Updating from $value to $new_value"
    echo $new_value > "$file"
    sleep 0.1
  done
}

# Run processes in background
process1 &
process2 &

# Wait some time to observe behavior
sleep 5

# Clean up processes (use `pkill -f process` on linux for a more robust solution)
kill $!
kill %2

# Final value can be inconsistent depending on race conditions
final_value=`cat "$file"`
echo "Final value: $final_value"