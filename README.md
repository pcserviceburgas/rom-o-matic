iPXE Prebuilt binary web interface [![Build Status](https://travis-ci.com/lps-rocks/rom-o-matic.svg?branch=master)](https://travis-ci.com/lps-rocks/rom-o-matic)
=====

## Demo
You can access a live version here: [rom-o-matic.dev](https://rom-o-matic.dev). Check the [server status](https://status.rom-o-matic.dev) page to check if the demo server is down. The demo server is rebuilt nightly and will be hosted indefinitely. This project is attempting to revive previous domains, rom-o-matic.eu and rom-o-matic.net as well.

## Why
A web interface for building iPXE binaries. Many users would prefer to be able to download prebuilt binary versions of iPXE, rather than building it from source.

This interface is built on previous work here: [https://github.com/xbgmsharp/ipxe-buildweb](https://github.com/xbgmsharp/ipxe-buildweb)

## What
A web-based user interface that provide a way for the user to select any relevant iPXE build options, specify any embedded script, etc, and then construct and download the appropriate file.

## How
The user interface, is using HTML, CSS as well as Javascript (jQuery) and a suitable server-side language (Perl).
All GUI options (git version/nics list/compile options) are generated from the iPXE source code dynamically.
The build.fcgi script written in Perl by Michael Brown.

## Using DockerHub image

[![dockeri.co](https://dockeri.co/image/lpsrocks/rom-o-matic)](https://hub.docker.com/r/lpsrocks/rom-o-matic)

* Supported tags:

    `latest` - Latest ([Dockerfile](https://github.com/lps-rocks/rom-o-matic/blob/master/Dockerfile))

* Supported architectures: x86-64

* Run rom-o-matic 

After a successful [Docker installation](https://docs.docker.com/engine/installation/) you just need to execute the following command in the shell:

```bash
docker run  -d \
	--publish 8080:80 \
	--name rom-o-matic \
    lpsrocks/rom-o-matic	
```

## Test using Docker

* Install Docker
[Install documentation of Docker](https://docs.docker.com/engine/installation/)

The Docker deb package are valid for Ubuntu and Debian.

```bash
$ wget http://get.docker.io/ -O - | sh
```

* Build the images

The following command build the build directly from the github repository.

The build process might take some time a while as it download the origin Ubuntu LTS 14.04 docker image.
```bash
$ docker build --rm=true --no-cache=true -t lpsrocks/rom-o-matic github.com/lps-rocks/rom-o-matic.git
```

Alternatively, you can build the image localy after cloning the repository.
```bash
$ docker build --rm=true --no-cache=true -t lpsrocks/rom-o-matic .
```

* Run the container

Run as a detach container
```bash
$ docker run -d -p 8080:80 -t lpsrocks/rom-o-matic
```

Or run the container with an attach shell
```
$ docker run -i --rm -p 22:22 -p 8080:80 -t lpsrocks/rom-o-matic /bin/bash
```

* Check the IP

```bash
$ docker ps -a
$ docker inspect CONTAINER_ID | grep IPA
```

Or both command in one
```bash
$ docker ps -a | grep ipxe-buildweb | awk '{print $1}' | xargs docker inspect | grep IPAddress
```

Or all in one with the ssh connection
```bash
$ ssh $(docker ps -a | grep ipxe-buildweb | awk '{print $1}' | xargs docker inspect | grep IPAddress | awk '{print $2}' | tr -d '"' | tr -d ',' )
```

* Login in the container via SSH

User is root and password is admin.

```bash
$ ssh root@172.17.0.x
```

* Review logs

```bash
$ docker logs CONTAINER_ID
```

* Enjoy!

## Contributing

1. Fork it
2. Create a branch (`git checkout -b my_markup`)
3. Commit your changes (`git commit -am "Added Snarkdown"`)
4. Push to the branch (`git push origin my_markup`)
5. Create an [Issue][1] with a link to your branch
6. Or Send me a [Pull Request][2]

[1]: https://github.com/lpsrocks/rom-o-matic/issues
[2]: https://github.com/lpsrocks/rom-o-matic/pull/new/master

## License
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
