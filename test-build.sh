#!/usr/bin/env bash

nix-build --show-trace --argstr vs-overlay $PWD everything-shell.nix
