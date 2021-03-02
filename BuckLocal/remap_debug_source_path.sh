#!/bin/bash
#
# This script creates a UUID.plist file inside the dSym bundle, and uses its `DBGSourcePathRemapping` config
# to remap remote pathes of apps repo to its local path.
#
# This is essential to enable debugging libraries fetched from Http cache built by a CI machine. Without this
# mapping, the breakpoints set locally won't work because LLDB won't be able to map those breakpoints to an address.
#
# This is still needed even if no Http cache is used, because the binaries compiled by Buck has relative path `./` in them,
# and LLDB needs absolute path to get breakpoints to work. However, if only `./` needs to be mapped, we may also use
# the LLDB config `target.source-map` to get it working, to avoid the creation of a DSYM file.
#
# We store all possible remote paths in a separate RemoteSourcePathList.txt file, so it's easier to maintain
# the list without touching the logic of generating the plist file.
#
DSYM_BUNDLE_PATH=$DWARF_DSYM_FOLDER_PATH/$DWARF_DSYM_FILE_NAME

# Wait for 1 second to make sure the DSYM bundle had been generated.
sleep 1
# Use dwarfdump to get the UUID of the DWARF file in the dSym bundle.
# The filename of the pList must match this UUID for the source path remapping to work.
UUID=`dwarfdump --uuid $DSYM_BUNDLE_PATH | cut -d ' ' -f 2`
# This is the path to the UUID.plist file we're about to create.
DSYM_PLIST_PATH=$DSYM_BUNDLE_PATH/Contents/Resources/$UUID.plist

# The following are 3 template files we use to construct the UUID.plist
DSYM_PLIST_PREFIX="$REPO_ROOT/BuckLocal/SourcePathRemapping_Prefix"
DSYM_PLIST_POSTFIX="$REPO_ROOT/BuckLocal/SourcePathRemapping_Postfix"
REMOTE_PATH_LIST="$REPO_ROOT/BuckLocal/RemoteSourcePathList.txt"

# Create the plist file
touch $DSYM_PLIST_PATH
# For the prefix template, we simply copy its content over.
cat $DSYM_PLIST_PREFIX > $DSYM_PLIST_PATH
# For the main mapping, we use awk to print each remote path as a Key in the plist, and the actual local repo path as the Value, so that we can map all remote pathes to local repo root.
cat $REMOTE_PATH_LIST | awk -v repo_root=$REPO_ROOT '{print "<key>"$1"</key><string>"repo_root"</string>"}' >> $DSYM_PLIST_PATH
# For the postfix template, we also copy its content over to the plist file without modification.
cat $DSYM_PLIST_POSTFIX >> $DSYM_PLIST_PATH
