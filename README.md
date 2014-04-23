## How to Use ##

Open up `Terminal.app` in your `/Applications/Utilities` directory, then type in these commands, one after each other:

1. Create a temporary directory for cycript:
   ```
   mkdir cycript && cd cycript
   ```

2. Pull the latest cycript from cycript.org:
   ```
   curl -L https://cydia.saurik.com/api/latest/3 -o cycript.zip
   ```

3. Unzip cycript:
   ```
   unzip cycript.zip
   ```
   
4. Download `fix_growlvoice.js`:
   ```
   curl https://gist.githubusercontent.com/kroo/11205755/raw/fix_growlvoice.js -o fix_growlvoice.js
   ```
   
5. Start GrowlVoice now.
   ```
   open -a GrowlVoice
   ```
   
6. A popup window should appear about malformed JSON.  Close it.

7. Ensure cycript is executable:
   ```
   chmod +x ./cycript
   ```
   
8. Patch the running GrowlVoice process:
   ```
   sudo ./cycript -p GrowlVoice fix_growlvoice.js
   ```

Each time you restart GrowlVoice, you will need to run this fix script again.  Run `cd ~/cycript && sudo ./cycript -p GrowlVoice fix_growlvoice.js` to run the script sometime later.