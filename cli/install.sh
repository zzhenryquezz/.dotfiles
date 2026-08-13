#!/usr/bin/env bash
set -e

DIRNAME="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BASENAME="$(basename -- "${BASH_SOURCE[0]}")"

bashly generate

ln -s "$DIRNAME/dot" ~/.local/bin/dot
