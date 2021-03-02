#!/bin/bash

set -e

# If env var REPO_ROOT is not set, we use git rev-parse to locate it
if [[ -z $REPO_ROOT ]]; then
  export REPO_ROOT=$(git rev-parse --show-toplevel)
fi
# If env var DEPS_LIST_FILE is not set, we use the default value.
if [[ -z $DEPS_LIST_FILE ]]; then
  DEPS_LIST_FILE="$REPO_ROOT/BuckLocal/lib_targets.list"
fi

# Call Buck Local, and ensure to redirect stdout to stderr so Xcode will show messages
cd $REPO_ROOT
rake buck_local:build_and_copy buck_binary_path="$REPO_ROOT/tools/buck" deps_list_file="$DEPS_LIST_FILE" 1>&2

exit 0
