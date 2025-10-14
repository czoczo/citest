#!/bin/bash

TESTS_SRC="$(dirname "$0")/tests"
if ! test -d "$TESTS_SRC"; then
  echo "No folder with tests found under $TESTS_SRC. Are you running tests from repository root directory?" >&2
  exit 1
fi

# text formatting
C0='\033[0m'      # Reset Color
CR='\033[0;31m'   # Red
CG='\033[0;32m'   # Green
CB='\033[0;33m'	  # Yellow
CB='\033[0;34m'	  # Blue
LB="======================================================================================"

RESULT=""
EXIT_CODE=0

for TEST in "$TESTS_SRC"/*.sh; do
  bash "$TEST" "$1"
  CURRENT_EXIT_CODE=$?
  RESULT="$RESULT\n"
  if [ "$CURRENT_EXIT_CODE" -ne 0 ]; then
    EXIT_CODE=1
    RESULT="$RESULT [ ${CR}FAIL${C0} ]"
  else
    RESULT="$RESULT [  ${CG}OK${C0}  ]"
  fi
  RESULT="$RESULT - ${TEST}"
done

echo -e "$RESULT"

echo -ne "\n\nOVERALL STATUS: "
if [ "$EXIT_CODE" -ne 0 ]; then
  echo -e "${CR}FAIL${C0}"
else
  echo -e "${CG}OK${C0}"
fi

exit $EXIT_CODE
