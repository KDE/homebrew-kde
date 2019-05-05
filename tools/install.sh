#!/usr/bin/env bash

[[ -f "/tmp/kf5_dep_map" ]] && rm /tmp/kf5_dep_map

formuladir="$(brew --repo kde-mac/kde)/Formula"

for formula in $formuladir/*.rb; do
  formulaname=`basename $formula`
  for dep in `grep "depends_on" $formula | awk -F "\"" '{print $2}'`; do
    echo "${dep/[k,K][d,D][e,E]-mac\/kde\//} ${formulaname//\.rb/}" >> /tmp/kf5_dep_map
  done
done

tsort /tmp/kf5_dep_map > /tmp/kf5_install_order

for formula in `cat /tmp/kf5_install_order`; do
  brew install "$@" "${formula}"
done
