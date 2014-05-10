Want to use GrowlVoice without the hassle of manually running a hack each time? Try this!

## Features

In short, this patch will make app should work just like before.

- Launch the app by launching the app, just like you used to!
- The "bad JSON" popup should never show up in the first place (no unreliable GUI scripting required).
- You can move GrowlVoice app anywhere you want.

## How to Patch

Please backup `GrowlVoice.app` beforehand!

1. From an admin account, download and `cd` to this repo.
2. `sudo bash patch.sh /path/to/GrowlVoice.app`
3. Open GrowlVoice and enjoy!

Want this all together? Log into an admin account and:

    git clone https://github.com/szhu/fix-growlvoice.git
    cd fix-growlvoice
    sudo bash patch.sh /path/to/GrowlVoice.app

(`/path/to/GrowlVoice.app` is `/Applications/GrowlVoice.app` if you leave it out.)

## Limitations

- May not work if you have multiple copies of GrowlVoice open. This isn't an additional limitation but a limitation of the cycript hack.

## Uninstalling

In case Google suddenly decides to make GrowlVoice work again

- Delete `/Library/Application Support/GrowlVoice`
- Delete `/Library/LaunchDaemons/com.interestinglythere.fixGrowlVoice.plist`
- Download a fresh copy of GrowlVoice or `sudo bash unpatch.sh /path/to/GrowlVoice.app`

## How it works & origins

[@kroo](https://www.github.com/kroo) wrote an [awesome fix for GrowlVoice](https://gist.github.com/kroo/11205755) that uses [cycript](http://www.cycript.org/). However, the hack must be manually run every time you launch GrowlVoice.

This is [@szhu](https://www.github.com/szhu)'s automation of that process. It does the following:

- Installs cycript and the original fix to `/Library/Application Support/GrowlVoice`
- Installs a privileged helper (LaunchDaemon) that runs whenever `/Library/Application Support/GrowlVoice/patch_now` is touched
- Modifies `GrowlVoice.app` to touch `/Library/Application Support/GrowlVoice/patch_now` at the appropriate time during launch

## Contributing

I want to know whether this fix works on all kinds of setups. **If this fix doesn't work for you, [please open a new issue](https://github.com/szhu/fix-growlvoice/issues)!** Pull requests are also very welcome.
