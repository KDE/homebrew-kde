#!/usr/bin/env bash

export IFS=" "

for formulapath in `brew --repo kde-mac/kde`/Formula/*; do
  if [[ `grep -c "caveats" "$formulapath"` -ge 1 ]]
  then
    formula=`basename $formulapath`
    formulaname=${formula/.rb/}
    formulainfo=`brew info $formulaname`
    if [[ `echo $formulainfo | grep -c "Built from source"` -ge 1 ]]
	then
      mkdir -pv $HOME/Applications/KDE
      echo "Linking $formulaname"
      eval `echo $formulainfo | grep "ln -s" | awk '{$1=$1; print $0}'`
    fi
  fi
done
