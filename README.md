# wp-utils

A collection of bash scripts to make it easier to manage our instance of WordPress
 
# Getting Started

copy settings.example.conf to settings.conf
change the values to match your environment

# Create a site

the script takes two arguments:  slug and name
it creates a site and outfits with the default configuration
`sh wp-create.sh "SITESLUG" "SITE NAME"`

# Add a user

the script takes three arguments:  site slug, user name, and role
it adds an existing user to the specified site with the specified role
sh wp-add-user.sh "SITESLUG" "USERNAME" "ROLE"
