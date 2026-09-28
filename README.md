# Assignment 1 – Linux/Bash/Networking/Git Diagnostics

This project implements a small set of Bash scripts that perform basic system diagnostics, disk checks, and network checks. It is designed to practice Linux command-line usage, Bash scripting, networking basics, and Git workflow.

***

## Project structure

```text
.
├── README.md
├── system-info.sh        # Display basic system information
├── disk-check.sh         # Check disk usage against a threshold
├── network-check.sh      # Check network connectivity to a host
├── logs/                 # Log files created by the scripts
└── grade.sh              # Provided grader script
```

(You may also have additional helper scripts or files as part of your implementation.)

***

## Requirements

- Bash
- Standard Linux utilities (`df`, `ping`, `ip` or `ifconfig`, `dig`/`getent`, etc.)
- Git (for commits and branch work)

***

## Scripts overview

### 1. `system-info.sh`

Displays basic Linux system information, such as:

- Hostname
- Current user
- Kernel version
- Uptime
- Basic memory/CPU info (if implemented)

**Usage:**

```bash
./system-info.sh
```

**Exit codes:**

- `0` – system information displayed successfully.
- Non-zero – runtime error while gathering information.

***

### 2. `disk-check.sh`

Checks disk usage for a filesystem and compares it against a threshold.

**Usage:**

```bash
# Threshold only (path defaults to /)
./disk-check.sh 80

# Threshold and explicit path
./disk-check.sh 80 /var
```

**Parameters:**

- `<threshold_percentage>` – integer from `1` to `100` (required)  
  Example: `80` means “alert if usage is 80% or higher.”
- `<path>` – filesystem path to check (optional)  
  Default: `/` if omitted.  
  Examples: `/`, `/var`, `/home`

**Behavior:**

- Displays the disk usage percentage for the specified path.
- Compares usage against the threshold.

**Exit codes:**

- `0` – disk usage is **below** the threshold.
- `1` – disk usage **reaches or exceeds** the threshold.
- `2` – invalid input, such as:
  - missing threshold
  - non-numeric threshold
  - threshold outside `1–100`
  - invalid path (if validated)

***

### 3. `network-check.sh`

Checks network connectivity to a specified host and optionally a specific TCP port.

**Usage:**

```bash
# Host only (basic connectivity)
./network-check.sh google.com

# Host and port (TCP connectivity check)
./network-check.sh google.com 443
```

**Parameters:**

- `<host>` – hostname or IP address (required)  
  Examples: `google.com`, `8.8.8.8`, `example.org`
- `<port>` – TCP port number (optional)  
  - Must be an integer between `1` and `65535`

**Behavior:**

- Validates the host argument.
- Resolves the host and displays the resolved address.
- Performs a basic connectivity check (e.g., ping).
- Displays local network interface information.
- If a port is supplied, checks TCP connectivity to that port.

**Exit codes:**

- `0` – host is reachable and all requested checks succeeded.
- `1` – host is unreachable or a requested connectivity check failed.
- `2` – invalid input, such as:
  - missing `<host>`
  - invalid hostname/IP format
  - invalid port (non-numeric, `< 1`, or `> 65535`)

***

## Logging

Scripts may create log files under the `logs/` directory to record execution details, such as:

- Start/end of script runs
- Success or failure messages
- Errors encountered

Example log location:

```text
logs/system-info-2026-09-28_14-00-00.log
```

Logging is typically implemented using redirection (`>>`) or `tee` inside the scripts.

***

## Running the grader

The provided `grade.sh` script checks:

- Required files exist (`README.md`, `system-info.sh`, `disk-check.sh`, `network-check.sh`)
- Bash syntax of all `.sh` files
- Executable permissions on the scripts
- Correct behavior and exit codes for each script
- Presence of log files under `logs/`
- Git history (at least 5 commits and at least one non-main branch)

To run the grader:

```bash
# Ensure grade.sh is executable
chmod +x grade.sh

# Run it
./grade.sh
```

The grader will print `PASS`/`FAIL` lines for each check and a summary of total passed and failed tests.

***

## Git requirements

This assignment also practices Git workflow:

- At least **5 commits** in the repository history.
- At least **one local branch** other than `main` (or `master`), such as:

  ```bash
  git checkout -b feature/system-info-improvements
  ```

- Commits should reflect meaningful changes (e.g., “Add disk-check threshold validation”, “Fix network-check port validation”, etc.).

***

## Exit code conventions

Across all scripts:

- `0` – success
- `1` – operational/runtime failure
- `2` – invalid command or invalid input (bad arguments, missing required arguments)

The grader relies on these conventions to determine pass/fail status.

***

## Notes

- Ensure all scripts are executable:

  ```bash
  chmod +x system-info.sh disk-check.sh network-check.sh grade.sh
  ```

- Run scripts from the project root so relative paths (like `logs/`) behave as expected.
- Use the grader output to guide fixes: any `FAIL` line indicates a specific requirement that needs attention.