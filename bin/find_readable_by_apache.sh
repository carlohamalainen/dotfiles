#!/bin/bash

# https://twitter.com/climagic/status/352164194751234048

find . -name '*.txt' \( -user apache -o \( \! -user apache -a -perm /044 \) \) # Find .txt files readable by apache user.
