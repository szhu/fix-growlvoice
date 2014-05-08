#!/usr/bin/env bash

# Patches GrowlVoice with @kroo's fix.
# 
# To revert this patch:
# - delete /Library/Application Support/GrowlVoice
# - delete /Library/LaunchDaemons/com.interestinglythere.fixGrowlVoice.plist
# - optionally delete /tmp/fix_growlvoice
# - download a fresh copy of GrowlVoice
# 
# To revert the GrowlVoice app manually
# - defaults write /path/to/GrowlVoice.app/Contents/Info CFBundleExecutable GrowlVoice
# - optionally delete /path/to/GrowlVoice.app/Contents/MacOS/GrowlVoice-helper

set -e

## Variables ##

if [ -z "$1" ] ; then
	APP='/Applications/GrowlVoice.app'
else
	APP="$1"
fi

if [ ! -d "$APP" ] ; then
	echo "GrowlVoice doesn't exist at $APP."
	echo "usage: sudo $0 [/path/to/GrowlVoice.app]"
	exit 1
fi

LAUNCHD_DIR='/Library/LaunchDaemons'
SUPPORT_DIR='/Library/Application Support/GrowlVoice'
CYCRIPT_DIR="$SUPPORT_DIR"/'cycript'
ORIG_EXE="$APP"/'Contents/MacOS/GrowlVoice'
HELPER_EXE_NAME='GrowlVoice-helper'
HELPER_EXE="$APP"/'Contents/MacOS'/"$HELPER_EXE_NAME"
SIGNAL='/tmp/fix_growlvoice'

set -x

## Install cycript ##

mkdir -p "$CYCRIPT_DIR"
curl -L 'https://cydia.saurik.com/api/latest/3' -o 'cycript.zip'
unzip 'cycript.zip' -d "$CYCRIPT_DIR"
cp 'fix_growlvoice.js' "$SUPPORT_DIR"/

## Install helper ##

cp -p "$ORIG_EXE" "$HELPER_EXE"
cp 'GrowlVoice-helper' "$HELPER_EXE"
# chmod --reference "$ORIG_EXE" "$HELPER_EXE" # unsupported on Mac, so use cp -p above
defaults write "$APP"/'Contents/Info' CFBundleExecutable "$HELPER_EXE_NAME"
chmod a+r "$APP"/'Contents/Info.plist'

## Install LaunchDaemon ##

cp 'com.interestinglythere.fixGrowlVoice.plist' "$LAUNCHD_DIR"/
touch "$SIGNAL"
chmod 777 "$SIGNAL"
launchctl load '/Library/LaunchDaemons'/'com.interestinglythere.fixGrowlVoice.plist'
