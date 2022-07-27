#!/bin/sh

docker build -t python . && docker run -p 9191:8080 python