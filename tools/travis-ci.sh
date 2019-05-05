#/usr/bin/env bash -ex

for file in "$@"; do
    if [[ $file =~ .rb$ ]] ; then
        brew install $file
    fi
done
