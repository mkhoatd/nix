#!/bin/bash

nix flake update --flake ~/.config/nix

nix run nix-darwin/master#darwin-rebuild -- switch --flake .

darwin-rebuild switch --flake .