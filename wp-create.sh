#!/bin/bash

# This script takes two arguments, the slug of the new WordPres site, and the site's title

if [[ $# -eq 0 ]] ; then
	echo 'No arguments provided'
	exit 0
fi

# Import the settings
. settings.conf

SLUG=$1
SITENAME=$2
SITEURL="$BASEURL$SLUG"

cd $PATHTOWORDPRESS
 
wp site create --slug=$SLUG

# Set options
wp option update uploads_use_yearmonth_folders 0 --url="$SITEURL"
wp option update blogname "$SITENAME" --url="$SITEURL"
wp option update blogdescription "" --url="$SITEURL"
wp option update timezone_string "America/New_York" --url="$SITEURL"
#discourage search engines
wp option update blog_public 0 --url="$SITEURL"

#set upload quota to 100MB
wp option update blog_upload_space 100 --url="$SITEURL"

# Discussion Settings
# uncheck Attempt to notify any blogs linked to from the post 
wp option update default_pingback_flag "" --url="$SITEURL"
# uncheck Allow link notifications from other blogs (pingbacks and trackbacks) on new posts 
wp option update default_ping_status "closed" --url="$SITEURL"
# uncheck Allow people to submit comments on new posts 
wp option update default_comment_status "closed" --url="$SITEURL"
# check Comment author must fill out name and email 
wp option update require_name_email 1 --url="$SITEURL"
# check Users must be registered and logged in to comment
wp option update comment_registration 1 --url="$SITEURL"
# check Automatically close comments on posts on older than ...
wp option update close_comments_for_old_posts 1 --url="$SITEURL"
# uncheck Show comments cookies opt-in checkbox
wp option update show_comments_cookies_opt_in 0 --url="$SITEURL"
# check Enable threaded (nested) comments
wp option update thread_comments 1 --url="$SITEURL"
# check Break comments into pages ...
wp option update page_comments 1 --url="$SITEURL"
# check Comment must be manually approved
wp option update comment_moderation 1 --url="$SITEURL"
# uncheck show avatars
wp option update show_avatars 0 --url="$SITEURL"

# set permalink structure
wp option update permalink_structure "/%postname%/" --url="$SITEURL"



# Activate plugins
wp plugin activate "advanced-custom-fields" --url="$SITEURL"
wp plugin activate "display-posts-shortcode" --url="$SITEURL"
wp plugin activate "multisite-custom-css" --url="$SITEURL"
wp plugin activate "uri-courses" --url="$SITEURL"
wp plugin activate "uri-people-tool" --url="$SITEURL"
wp plugin activate "wp-lightbox-2" --url="$SITEURL"


# Note: these use --quiet because they put out many useless warning messages
# Trash default page
wp post delete $(wp post list --post_title='Sample Page' --post_type='post,page' --url="$SITEURL") --url="$SITEURL" --quiet
# Trash sample default post
wp post delete $(wp post list --post_title='Hello World!' --post_type='post,page' --url="$SITEURL") --url="$SITEURL" --quiet
