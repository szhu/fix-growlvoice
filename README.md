Want to use GrowlVoice without the hassle of manually running a hack each time? Try this!

## [tl;dr](http://szhu.github.io/fix-growlvoice/)

## Features

In short, this patch will make app should work just like before.

- Launch the app by launching the app, just like you used to!
- The "bad JSON" popup should never show up in the first place (no unreliable GUI scripting required).
- You can move GrowlVoice app anywhere you want.

## Patch

From an admin account and

    git clone https://github.com/szhu/fix-growlvoice.git
    cd fix-growlvoice
    sudo bash patch.sh /path/to/GrowlVoice.app

(`/path/to/GrowlVoice.app` is `/Applications/GrowlVoice.app` if you leave it out.)

That's it! Now you can enjoy using GrowlVoice again.

## Alternate patch

An alternate version of the patch works only for unsigned versions of GrowlVoice. If original patch doesn't work, try this one. This patch also seems to be more robust.

This may work better because it modifies GrowlVoice itself instead of creating a wrapper app around it with the same name (and metadata), which may confuse some systems.

This alternate patch won't work with Mac App Store versions of the app; those are [code signed](https://en.wikipedia.org/wiki/Code_signing) and refuse to run when they are modified. You will need to obtain an unsigned version of GrowlVoice. [You can find some here.](http://www.google.com/search?q=growlvoice+2.0.3+cracked) You can also self-sign the app after the patch is complete.

To use, run `./patch-alternate` instead of `./patch`. `cd` to into the repo root, not to in`alternate`.

## Limitations

- May not work if you have multiple copies of GrowlVoice open. This isn't an additional limitation but a limitation of the cycript hack.

## Uninstalling

In case Google suddenly decides to make GrowlVoice work again

- Delete `/Library/Application Support/GrowlVoice`
- Delete `/Library/LaunchDaemons/com.interestinglythere.fixGrowlVoice.plist`
- Download a fresh copy of GrowlVoice or `sudo bash unpatch_app /path/to/GrowlVoice.app`

## How it works & origins

[@kroo](https://www.github.com/kroo) wrote an [awesome fix for GrowlVoice](https://gist.github.com/kroo/11205755) that uses [cycript](http://www.cycript.org/). However, the hack must be manually run every time you launch GrowlVoice.

This is [@szhu](https://www.github.com/szhu)'s automation of that process. It does the following:

- Installs cycript and the original fix to `/Library/Application Support/GrowlVoice`.
- Installs a privileged helper (LaunchDaemon) that is bound to the world-writable socket `/Library/Application Support/GrowlVoice/socket`. This allows all users to launch the helper.
- Modifies `GrowlVoice.app` to connect to this socket on launch.

## Contributing

I want to know whether this fix works on all kinds of setups. **If this fix doesn't work for you, [please open a new issue](https://github.com/szhu/fix-growlvoice/issues)!** Pull requests are also very welcome.
