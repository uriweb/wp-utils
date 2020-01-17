#!/bin/bash

# This script takes three arguments:
# - the slug of the WordPres site to which we add users
# - the username
# - the users's role

if [[ $# -eq 0 ]] ; then
	echo 'No arguments provided'
	exit 0
fi

# Import the settings
. settings.conf

SLUG=$1
SITEURL="$BASEURL$SLUG"
USER=$2
ROLE=$3

cd $PATHTOWORDPRESS

wp user set-role $USER $ROLE --url="$SITEURL"
