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
# - replace /path/to/GrowlVoice.app with /path/to/GrowlVoice.app/Contents/MacOS/GrowlVoice.app

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
APP_NAME='GrowlVoice.app'
NEW_APP="$APP"/'Contents/MacOS'/"$APP_NAME"
EXE_NAME='GrowlVoice'
HELPER_EXE="$APP"/'Contents/MacOS'/"$EXE_NAME"
SIGNAL='/tmp/fix_growlvoice'

set -x

## Install cycript ##

mkdir -p "$CYCRIPT_DIR"
curl -L 'https://cydia.saurik.com/api/latest/3' -o 'cycript.zip'
unzip 'cycript.zip' -d "$CYCRIPT_DIR"
cp 'fix_growlvoice.js' "$SUPPORT_DIR"/

## Move stuff ##

if [ ! -d "$NEW_APP" ] ; then
	mv "$APP"/'Contents' "$APP"/'Contents-old'
	mkdir -p "$NEW_APP"
	mv "$APP"/'Contents-old' "$NEW_APP"/'Contents'
	ln -s 'MacOS'/"$APP_NAME"/'Contents'/{'Info.plist','Resources','PkgInfo'} "$APP"/'Contents'/
fi

## Install helper ##

cp 'GrowlVoice-helper' "$HELPER_EXE"
chmod 777 "$HELPER_EXE"

## Install LaunchDaemon ##

cp 'com.interestinglythere.fixGrowlVoice.plist' "$LAUNCHD_DIR"/
touch "$SIGNAL"
chmod 777 "$SIGNAL"
launchctl load '/Library/LaunchDaemons'/'com.interestinglythere.fixGrowlVoice.plist'
