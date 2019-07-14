#!/bin/bash

#ffmpeg -i ORIG.aa -codec copy NEW.mp3

ffmpeg -i $1 -codec copy $1.mp3
