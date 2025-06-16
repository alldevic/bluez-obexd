#!/usr/bin/make

.PHONY: build run clean oldconfig menuconfig sh patch_config
.DEFAULT_GOAL := run

SHELL = /bin/bash

DOCKER_RUN = docker run --rm -it

ARTIFACTS=-v ./artifacts/:/app/assets/

IMG_NAME=dm-bluez

build:
	docker build --progress plain -t $(IMG_NAME) .

run: build
	time $(DOCKER_RUN) $(ARTIFACTS) $(IMG_NAME):latest

clean:
	rm -rf KDEB_PKGVERSION ./artifacts/*
	touch ./artifacts/.gitkeep

sh:
	$(DOCKER_RUN) $(IMG_NAME):latest bash