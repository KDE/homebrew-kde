#/usr/bin/env bash -ex

for file in "$@"; do
    if [[ $file =~ .rb$ ]] ; then
		brew style $file
		brew audit --strict $file
		brew install $file
		brew test $file
		brew audit --strict $file
    fi
done
