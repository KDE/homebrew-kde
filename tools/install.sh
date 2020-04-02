#!/usr/bin/env bash

rm -f /tmp/kf5_dep_map /tmp/kf5_filtered

`brew list > /tmp/brew_installed.list`

formuladir="$(brew --repo kde-mac/kde)/Formula"

for formula in $formuladir/*.rb; do
  formulaname=`basename $formula`
  for dep in `grep "depends_on" $formula | awk -F "\"" '{print $2}'`; do
    echo "${dep/[k,K][d,D][e,E]-mac\/kde\//} ${formulaname//\.rb/}" >> /tmp/kf5_dep_map
  done
done

tsort /tmp/kf5_dep_map > /tmp/kf5_install_order 2> /dev/null

for candidate_formula in `cat /tmp/kf5_install_order`; do
  for installed_formula in `cat /tmp/brew_installed.list`; do
    if [[ "${candidate_formula}" == "${installed_formula}" ]]; then
      continue 2
    fi
  done
  echo "${candidate_formula}" >> /tmp/kf5_filtered
done

for formula in `cat /tmp/kf5_filtered`; do
  brew install "$@" "${formula}" || true
done
