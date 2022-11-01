#!/bin/bash

brew update
HOMEBREW_NO_AUTO_UPDATE=1

tmp_kde=/tmp/kde
formulas="${tmp_kde}/formulas"
bundle="${tmp_kde}/Brewfile"
kde_tap_dir="$(brew --repo kde-mac/kde)"

rm -f "${formulas}" "${bundle}"
mkdir -p "${tmp_kde}"

formula_dir="${kde_tap_dir}/Formula"
for formula in "${formula_dir}"/*.rb; do
  formula_file=`basename "${formula}"`
  formula_name=${formula_file//\.rb/}
    if grep -q -E -l 'url "http|url "file' "${formula}"; then
      echo "brew \"kde-mac/kde/${formula_name}\"" >> "${bundle}"
    else
      echo "brew \"kde-mac/kde/${formula_name}\", args: [\"HEAD\"]" >> "${bundle}"
    fi
done

casks_dir="${kde_tap_dir}/Casks"
for cask in "${casks_dir}"/*.rb; do
  cask_file=`basename "${cask}"`
  cask_name="${cask_file//\.rb/}"
  echo "cask \"kde-mac/kde/${cask_name}\"" >> "${bundle}"
done

cp "${bundle}" "${kde_tap_dir}"
