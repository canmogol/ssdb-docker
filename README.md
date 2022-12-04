# Docker image for SSDB

This repository contains Dockerfile to build an image that dock [SSDB](http://ssdb.io/) service.

## Usage

### Build this image

The pre-built image is published in Docker Hub with name `canmogol/ssdb`

To build it yourself, run this command on project directory:
```sh
$ docker build -t <your_image_name_here>[:<tag name>] .
```

### Run service
Run with default configuration:
```sh
$ docker run -d -p 8888:8888 canmogol/ssdb:0.0.1 
```
NOTE: Replace `-p 8888:8888` with `-p <your_external_port>:8888`

Run with custom configuration
```sh
$ docker run -d --name <your_container_name> \
	-p <your_external_port>:8888 \
	-v <data_folder_on_host>:/usr/local/ssdb/var/data:rw \
	-v <meta_folder_on_host>:/usr/local/ssdb/var/meta:rw \
	[-v <location_of_config_file_on_host>:/usr/local/ssdb/ssdb.conf] \
	canmogol/ssdb:0.0.1
```

By default logs are written to stdout
