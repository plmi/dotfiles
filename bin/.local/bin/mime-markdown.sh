#!/bin/bash

# add markdown support for firefox
# https://superuser.com/a/1606869

sudo mkdir -p /usr/local/share/mime/packages
sudo tee /usr/local/share/mime/packages/text-markdown.xml > /dev/null <<EOL
<?xml version="1.0"?>
<mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
  <mime-type type="text/plain">
    <glob pattern="*.md"/>
    <glob pattern="*.mkd"/>
    <glob pattern="*.markdown"/>
  </mime-type>
</mime-info>
EOL
sudo update-mime-database /usr/local/share/mime
