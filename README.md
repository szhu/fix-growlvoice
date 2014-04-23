## How to Use ##

Open a `Terminal.app` in your applications directory, then run these commands, one after each other:

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