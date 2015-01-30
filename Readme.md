| Note |
|:---- |
| This project has been superceded by [d235j/GVFixer](https://github.com/d235j/GVFixer), which appears to work a lot better and can be installed per-user. If you're bent on using this project instead of GVFixer, check [#6](https://github.com/szhu/fix-growlvoice/issues/6) for the discussion on Yosemite compatibility. |

# Fix GrowlVoice

## 30-second quick install » [see here](http://szhu.github.io/fix-growlvoice/)

## Features

In short, this patch will make app should work just like before.

- Launch the app by launching the app, just like you used to!
- You can move GrowlVoice app anywhere you want.
- You can have multiple copies of GrowlVoice running (i.e., have multiple users using GrowlVoice). This wasn't possible with [the original patch](https://gist.github.com/kroo/11205755).
- The "bad JSON" popup should never show up in the first place (no unreliable GUI scripting required). This was possible with [the original patch](https://gist.github.com/kroo/11205755), but only if you had impeccable timing.

## Patch

From an admin (sudoer) account:

    git clone https://github.com/szhu/fix-growlvoice.git
    cd fix-growlvoice
    sudo ./install-patch /path/to/GrowlVoice.app

(`/path/to/GrowlVoice.app` is `/Applications/GrowlVoice.app` if you leave it out.)

That's it! Now you can enjoy using GrowlVoice again.

New to GrowlVoice? You'll have to set up your account manually. [Read here.](For New GrowlVoice Users.md)

## Alternate patch

An alternate, slightly more robust version of the patch works only for unsigned versions of GrowlVoice. If original patch doesn't work, try this one.

This may work better because it modifies GrowlVoice itself instead of creating a wrapper app around it with the same name (and metadata), which may confuse some systems.

This alternate patch won't work with Mac App Store versions of the app; those are [code signed](https://en.wikipedia.org/wiki/Code_signing) and refuse to run when they are modified. You will need to obtain an unsigned version of GrowlVoice, which [you can find here](http://www.google.com/search?q=growlvoice+2.0.3+cracked). You can also try to self-sign the app after patching.

To use, run `./install-alternate-patch` instead of `./install-patch`.

## Uninstalling

In case Google suddenly decides to make GrowlVoice work again

- Delete `/Library/Application Support/GrowlVoice`
- Delete `/Library/LaunchDaemons/com.interestinglythere.fixGrowlVoice.plist`
- `sudo launchctl unload com.interestinglythere.fixGrowlVoice`
- Download a fresh copy of GrowlVoice or `./unpatch-app /path/to/GrowlVoice.app`

## How it works & origins

[@kroo](https://www.github.com/kroo) wrote an [awesome fix for GrowlVoice](https://gist.github.com/kroo/11205755) that uses [cycript](http://www.cycript.org/). However, the hack must be manually run every time you launch GrowlVoice.

This is [@szhu](https://www.github.com/szhu)'s automation of that process. It does the following:

- Installs cycript and the original fix to `/Library/Application Support/GrowlVoice`.
- Installs a privileged helper (LaunchDaemon) that is bound to the world-writable socket `/Library/Application Support/GrowlVoice/socket`. This allows all users to launch the helper.
- Modifies `GrowlVoice.app` to connect to this socket on launch by adding a helper:
	- The main patch wraps the entire app in a helper app.
	- The alternate patch adds a helper executable (instead of an entire app) in `MacOS`. This is more straightforward, but since it modifies the app, signed apps won't allow this.

## Contributing

I want to know whether this fix works on all kinds of setups. **If this fix doesn't work for you, [please open a new issue](https://github.com/szhu/fix-growlvoice/issues)!** Pull requests are also very welcome.
