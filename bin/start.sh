#!/bin/sh

# Create temporary directories
mkdir -p /tmp/ipxe/build
mkdir -p /tmp/ipxe/cache 

# Clean temporary directories
rm -Rf /tmp/ipxe/build/*
rm -Rf /tmp/ipxe/cache/*

# Clone iPXE into temporary source as apache
if [[ ! -d /tmp/ipxe/source ]]; then
	git clone https://github.com/ipxe/ipxe.git /tmp/ipxe/source
else
    git pull
fi

# Change owner of files
chown apache:apache -Rf /tmp/ipxe/

# Build Cache files
cd /tmp/ipxe/source/src/
perl /opt/rom-o-matic/bin/parseheaders.pl > /var/www/rom-o-matic/options.json
perl /tmp/ipxe/source/src/util/niclist.pl --format json --columns ipxe_name,device_id,vendor_id > /var/www/rom-o-matic/nics.json
git rev-list --all --max-count=20 --abbrev-commit --abbrev=1 | jq -R -s -c 'split("\n")' > /var/www/rom-o-matic/versions.json

# Launch Apache
exec "$@"
