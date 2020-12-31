#/bin/bash -ex

for file in "$@"; do
    if [[ $file =~ .rb$ ]] ; then
		brew style $file
		brew audit --strict $file
		if brew ls --formula|grep ${file#.rb} ; then
			brew upgrade -vd $file
		else
			brew install $file
		fi
		brew test $file
		brew audit --strict $file
    fi
done
