#!/usr/bin/env bash
set -e

bashly generate

install -m 755 ./dot ~/.local/bin/dot
