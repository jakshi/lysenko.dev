+++
title = "Disable MacOS X dark mode for specific application"
date = "2019-08-21T14:22:00+07:00"
draft = false
tags = ["macosx", "dark mode"]
topics = []
description = ""
+++

# Intro
I use some KDE applications on my Macbook Pro.  
And some of them looks very bad with MacOS X dark mode.  
So I would like to disable dark mode for those specific applications.

<!--more-->

# Howto
First I need to find out a Bundle identifier of the application.

```
$ sudo find / -iname kmymoney.app 2>&1 | grep -v "Operation not permitted"
/usr/local/Cellar/kmymoney/5.0.6_1/bin/kmymoney.app
$ cd /usr/local/Cellar/kmymoney/5.0.6_1/bin/kmymoney.app/Contents/
$ $ cat Info.plist |grep -A 1 CFBundleIdentifier
	<key>CFBundleIdentifier</key>
	<string>org.kde.KMyMoney</string>
```

so bundle identifier is `org.kde.KMyMoney`

Then let's disable dark mode for KMyMoney:

```
defaults write org.kde.KMyMoney NSRequiresAquaSystemAppearance -bool yes
```

if we would need to enable it back - we would need to execute:

```
defaults write org.kde.KMyMoney NSRequiresAquaSystemAppearance
```

# References

* [How to Exclude an App From Dark Mode in macOS Mojave](https://www.techjunkie.com/exclude-app-dark-mode-macos-mojave/)
* [Reddit: How to enable Mojave dark mode for applications that don't support it](https://www.reddit.com/r/apple/comments/9jr2zy/how_to_enable_mojave_dark_mode_for_applications/)
