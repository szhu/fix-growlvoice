## For new GrowlVoice users

 - New to GrowlVoice?
 - Setting up GrowlVoice on a fresh user account?
 - Want to change GrowlVoice accounts?

Read this!

1. `defaults write com.erichoracek.GrowlVoice GVAccountsArray '({GVAccountsUsername = "YOURUSERNAME";})'`

    If you have multiple accounts, use `({GVAccountsUsername = "YOURUSERNAME1";},{GVAccountsUsername = "YOURUSERNAME2";})` instead.

2. Open the Keychain Access app.

3. Add a new keychain item:

    ![Adding new keychain item screenshot](https://cloud.githubusercontent.com/assets/1570168/3006673/f7d1d5e4-de3f-11e3-9520-91651ebf4159.png)

4. Show info (right-click » _Get Info_) for the keychain item.

    ![Keychain item info screenshot](https://cloud.githubusercontent.com/assets/1570168/3006674/fa655b78-de3f-11e3-983a-a2576aae3ffe.png)

    Try adding GrowlVoice to the list of allowed apps. This doesn't always work because the app is patched; if it fails, you can allow all apps to access the keychain item. This is a bit insecure (any running app can access your password) but still relatively secure (nothing and nobody can access your password if you're not logged in).

Does this not work for you? Do you know how to get step 4 to always work? [Please open a new issue!](https://github.com/szhu/fix-growlvoice/issues)
