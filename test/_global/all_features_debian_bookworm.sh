#!/bin/bash
set -e

source dev-container-features-test-lib

check "gcloud installed" bash -c "gcloud --version >/dev/null"
check "jq installed" bash -c "jq --version >/dev/null"
check "op installed" bash -c "op --version >/dev/null"
check "shell-history mount path present" bash -c "test -d /dc/shellhistory"

reportResults
