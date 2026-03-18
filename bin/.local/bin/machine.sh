#!/bin/bash

# OSCP Lab Directory Scaffolder
# Usage: ./new_machine.sh <platform> <machine_name>

BASE_DIR="$HOME/OSCP"

declare -A PLATFORMS=(
    ["offsec"]="01_OffSec"
    ["pg"]="02_ProvingGrounds"
    ["htb"]="03_HackTheBox"
    ["thm"]="04_TryHackMe"
)

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <platform> <machine_name>"
    echo ""
    echo "Platforms:"
    echo "  offsec  - OffSec Labs"
    echo "  pg      - Proving Grounds"
    echo "  htb     - Hack The Box"
    echo "  thm     - TryHackMe"
    echo ""
    echo "Example: $0 htb Lame"
    exit 1
fi

PLATFORM_KEY="${1,,}"  # lowercase
MACHINE_NAME="$2"

if [[ -z "${PLATFORMS[$PLATFORM_KEY]}" ]]; then
    echo "Error: Unknown platform '$1'"
    echo "Valid options: offsec, pg, htb, thm"
    exit 1
fi

MACHINE_DIR="$BASE_DIR/${PLATFORMS[$PLATFORM_KEY]}/$MACHINE_NAME"

if [[ -d "$MACHINE_DIR" ]]; then
    echo "Warning: $MACHINE_DIR already exists."
    exit 1
fi

mkdir -p "$MACHINE_DIR"/{scans,loot,exploits}

cat > "$MACHINE_DIR/notes.org" << EOF
#+TITLE: $MACHINE_NAME
#+AUTHOR:
#+DATE: $(date +%Y-%m-%d)

* Info
:PROPERTIES:
:Platform: ${PLATFORMS[$PLATFORM_KEY]#*_}
:IP:
:OS:
:Difficulty:
:Status: In Progress
:END:

* Recon
** Port Scan
** Service Enumeration
** Web Enumeration

* Foothold

* Privilege Escalation

* Flags
- local.txt:
- proof.txt:

* Loot
** Credentials
| Username | Password | Service |
|----------+----------+---------|
|          |          |         |

** Hashes
| User | Hash |
|------+------|
|      |      |

* Lessons Learned

EOF

echo "Created: $MACHINE_DIR"
echo "  ├── scans/"
echo "  ├── loot/"
echo "  ├── exploits/"
echo "  └── notes.org"
