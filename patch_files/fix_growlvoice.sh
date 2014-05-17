#!/bin/bash

read pid
echo "fix_growlvoice.sh: GrowlVoice PID: $pid"
./cycript/cycript -p "$pid" fix_growlvoice.js
echo 'fix_growlvoice.sh: all done'