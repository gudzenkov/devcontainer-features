#!/bin/bash
set -e

# Clean up
rm -rf /var/lib/apt/lists/*

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

apt_get_update()
{
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update -y
    fi
}

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        apt_get_update
        apt-get -y install --no-install-recommends "$@"
    fi
}

export DEBIAN_FRONTEND=noninteractive
ONEPASSWORD_KEY_FINGERPRINT="3FEF9748469ADBE15DA7CA80AC2D62742012EA22"

# Source /etc/os-release to get OS info
. /etc/os-release

# Install dependencies
check_packages apt-transport-https curl ca-certificates gnupg2 dirmngr
# Import key safely (new 'signed-by' method rather than deprecated apt-key approach) and install
curl -fsSL https://downloads.1password.com/linux/keys/1password.asc -o /tmp/1password.asc
actual_fingerprint="$(gpg --show-keys --with-colons /tmp/1password.asc | awk -F: '/^fpr:/ { print $10; exit }')"
if [ "${actual_fingerprint}" != "${ONEPASSWORD_KEY_FINGERPRINT}" ]; then
    echo "1Password repository key fingerprint mismatch." >&2
    echo "Expected: ${ONEPASSWORD_KEY_FINGERPRINT}" >&2
    echo "Actual:   ${actual_fingerprint}" >&2
    exit 1
fi
gpg --dearmor < /tmp/1password.asc > /usr/share/keyrings/1password-archive-keyring.gpg
rm -f /tmp/1password.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" > /etc/apt/sources.list.d/1password.list

# Update lists
apt-get update -yq

apt-get install -yq 1password-cli  || exit 1
