#!/usr/bin/env bash

VERSION=5.45.0

for FORMULA in $(brew --repo kde-mac/kde)/Formula/kf5-tier*; do

  PREVIOUS_VERSION=$(sed -n 's/.*version "\(.*\)"/\1/p' $FORMULA)

  if [ $VERSION != $PREVIOUS_VERSION ]; then
    echo Updating version $PREVIOUS_VERSION to $VERSION in $(basename $FORMULA)
    sed -i "s/$PREVIOUS_VERSION/$VERSION/g" $FORMULA
  else
    echo No change to version in $(basename $FORMULA)
  fi

done
