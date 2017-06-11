#/bin/bash

# This is DEPRECATED, I'm using
# https://github.com/humitos/emacs-x11-alpine now

set -e

rm -rf repo.tar
rm -rf repo

python bin/git_archive_all.py --force-submodules repo.tar
tar xvf repo.tar
docker build --file Dockerfile-local --tag humitos/emacs-x11-alpine .

rm -rf repo.tar
rm -rf repo

docker push humitos/emacs-x11-alpine
