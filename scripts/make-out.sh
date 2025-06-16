#! /bin/bash

rm -rf /app/assets/*
mv ./*.deb /app/assets/
chown -R 1000:1000 /app/assets/
