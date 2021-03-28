# basic-init

A simple, bash-based init script that works on any machine that has bash (like a seedbox).

I created this because I buy a ton of seedboxes with bash support but no ability to install apps, so I have to compile and run them manually in the background. Think `/etc/init.d` but with `screen`.

## Pre-requisites

* `bash` (99.9% chance you already fulfill this requirement on a Linux machine)
* `screen` (`apt-get install screen` or `yum install screen` or `dnf install screen`, most seedboxes already have this installed)

## Usage

Edit the `service.sh` script's `start()` section (look for the comment that says "Run your app here"). Save, then grant it execution permissions: `chmod +x /path/to/service.sh`.

You can then stop, start, restart or view the status of your background app:

* `bash service.sh start` - starts the app
* `bash service.sh stop` - stops the app
* `bash service.sh restart` - restarts the app, simply calls `stop` and `start`
* `bash service.sh status` - returns the status of your app's screen session

## License

This script is licensed under the [WTFPL](http://www.wtfpl.net/) license. Basically, do whatever you want with it with the thought that if something goes wrong, you're on your own.

I wrote this in 15 minutes so there may be issues/better ways to do this. It works for my use-case and I hope it helps you too.
