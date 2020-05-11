#------------------------------------------------------------------------
# Dynamic iPXE image generator
#
# Copyright (C) 2012-2019 Francois Lacroix. All Rights Reserved.
# License:  GNU General Public License version 3 or later; see LICENSE.txt
# Website:  http://ipxe.org, https://github.com/xbgmsharp/ipxe-buildweb
#------------------------------------------------------------------------
#
# Alpine Linux + Apache2 + module + my app
#
# Base from ultimate-seed Dockerfile
# https://github.com/pilwon/ultimate-seed
#
# AUTHOR: xbgmsharp@gmail.com
# WEBSITE: https://github.com/xbgmsharp/ipxe-buildweb
#
# DOCKER-VERSION 1.0.0
# VERSION 0.0.1

# Pull base image.
FROM alpine
MAINTAINER James DeVincentis <jd@lps.rocks>

# Upgrade existing base packages
RUN apk --no-cache upgrade

# Install System Dependencies
RUN apk add --no-cache wget sudo bash

# Install Compiling Dependencies 
RUN apk add make gcc libc-dev zlib-dev openssl-dev xz-dev binutils-dev cdrkit syslinux

# Perl and Perl Dependencies
RUN apk add --no-cache perl perl-json perl-cgi perl-fcgi perl-uri perl-config-inifiles perl-ipc-system-simple perl-app-cpanminus 
RUN cpanm Sub::Override 

# Install git & jq 
RUN apk add --no-cache git jq

# Install Apache2
RUN apk add --no-cache apache2 apache-mod-fcgid

# Configure Apache2
ADD etc/apache.conf /etc/apache2/conf.d/rom-o-matic.conf
RUN ln -s /dev/stderr /var/log/apache2/error.log
RUN ln -s /dev/stdout /var/log/apache2/access.log

# Install rom-o-matic WebUI
ADD html/ /var/www/rom-o-matic/

# Copy parseheaders utility
ADD bin/parseheaders.pl /opt/rom-o-matic/bin/ 
ADD bin/start.sh /
RUN chmod +x /start.sh

# Clean up CPAN
RUN rm -Rf /root/.cpanm/

# Expose ports.
EXPOSE 80

# Launch apache as the server
ENTRYPOINT ["/start.sh"]
CMD ["httpd", "-D", "FOREGROUND"]
