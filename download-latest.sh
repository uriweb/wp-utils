#!/bin/bash

if [[ $# -eq 0 ]] ; then
	echo 'No arguments provided, please specify the plugin repository name'
	exit 0
fi

PLUGIN=$1

# get the tarball URL for the latest tag
URL=$(curl --silent "https://api.github.com/repos/uriweb/$PLUGIN/releases/latest" | grep '"zipball_url":' | sed -E 's/.*"([^"]+)".*/\1/')

# change to a temporary destination directory
mkdir -p 'transient'
cd 'transient'

# if the plugin directory exists, remove it.
rm -Rf $PLUGIN

# download the latest package
curl -L --silent "$URL" > $PLUGIN'.zip'

# unzip package to a directory called "temp"
unzip -q $PLUGIN".zip" -d "./temp"

# github may rename the package, this will change the directory the plugin name
mv temp/uriweb-$PLUGIN-* "$PWD/$PLUGIN"

# clean up the "temp" directory now that we're done with it
rm -R temp
