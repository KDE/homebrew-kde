#!/bin/bash

[[ -f "/tmp/kf5_dep_map" ]] && rm /tmp/kf5_dep_map

for formula in `ls kf5-*.rb`; do
  for dep in `grep "depends_on" $formula | awk -F "\"" '{print $2}'`; do
  echo -n "${dep/haraldf\/kf5\//} " >> /tmp/kf5_dep_map
  echo "${formula/.rb/}" >> /tmp/kf5_dep_map
  done
done

tsort /tmp/kf5_dep_map > /tmp/kf5_install_order



for formula in `cat /tmp/kf5_install_order`; do
  brew install "$@" "${formula}"
done
