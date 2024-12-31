# Race Condition in Bash Script

This repository demonstrates a common error in shell scripting: a race condition when multiple processes concurrently update a shared file.  The script `bug.sh` shows how this leads to unpredictable results, while `bugSolution.sh` presents a corrected version using a lock file to prevent concurrent access.  This example highlights the importance of proper synchronization in multi-process scripts to ensure data integrity.