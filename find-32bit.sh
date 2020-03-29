#!/bin/bash

starthere="/Applications /Library ~/Applications ~/Library "

sudo find $starthere -type d -name \*.app |  \
    while read app ; do
	appname=`basename "$app"`
	echo "$appname:$app"
    done | sort | \
    while read x ; do
	appname=`echo "$x" | sed 's/:.*$//'`
	app=`echo "$x" | sed 's/^.*://'`
	
        [ -d "$app"/Contents ] && ( cd "$app"/Contents
	if [ -f Info.plist ] ; then
	    exe=`plutil -p Info.plist | awk '/CFBundleExecutable/' | sed 's/^.*=> *//' | sed 's/"//g'`
	    ft=`file MacOS/"$exe" |grep -q i386 && echo "i386"`
	    if [ "$ft" = "i386" ] ;then
		echo "$appname"
		echo "      $app"
		echo "      $exe"
	    fi
	fi
	
	)
	
    done
