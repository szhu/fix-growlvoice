## How to Use Alternate Version ##

An alternate version of the patch works only for unsigned versions of GrowlVoice. If original patch doesn't work, try this one.

This may work better because it modfies GrowlVoice itself instead of creating a wrapper app around it with the same name (and metadata), which may confuse some systems.

This alternate patch won't work with Mac App Store versions of the app; those are [code signed](https://en.wikipedia.org/wiki/Code_signing) and refuse to run when they are modified. You will need to obtain an unsigned version of GrowlVoice. [You can find some here.](http://www.google.com/search?q=growlvoice+2.0.3+cracked) You can also self-sign the app after the patch is complete.

If you already ran the original patch, undo the patch for at least the GrowlVoice app before applying this one.

To use, run `alternate/patch.sh` instead of `patch.sh`. Run from the repo root, not from this directory.
