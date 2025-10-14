#!/bin/bash
VERSION="0.2.0"
DESCRIPTION="Testing if Terraform modules have valid code (terraform validate)."
INSTALL_MSG="Install: https://developer.hashicorp.com/terraform/install"

CMD="terraform"
VERSION_ARG="-version"


# option handling
while test $# -gt 0
do
    case "$1" in
        -all) CHECK_ALL=1
            ;;
        -*) echo "bad option $1"
            exit 1
            ;;
    esac
    shift
done

TEST="$CMD -chdir='\$TFDIR' init -backend=false && $CMD -chdir='\$TFDIR' validate"

# ---

echo "$TEST"
