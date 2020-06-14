#!/bin/bash

mkdir -p ~/.ssh

cp ./id_ed25519_git_sync ~/.ssh
cp ./id_ed25519_git_sync.pub ~/.ssh
cp ./config ~/.ssh

chmod 600 ~/.ssh/id_ed25519_git_sync

