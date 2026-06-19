#!/bin/bash

# Detect Kernel & OS
case "$(uname -s)" in
    Linux*)     KERNEL=Linux ;;
    Darwin*)    KERNEL=macOS ;;
    CYGWIN*)    KERNEL=Cygwin ;;
    *)          KERNEL="UNKNOWN" ;;
esac

# Detect Hardware Architecture
ARCH=$(uname -m)
OS_NAME=$(uname -o)

# Deep Dive into Linux Distributions
if [ "$KERNEL" == "Linux" ]; then
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID  # Result: 'ubuntu', 'fedora', 'arch', etc.
    else
        DISTRO="Unknown Linux"
    fi
fi
