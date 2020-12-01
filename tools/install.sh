#!/bin/bash

brew update
HOMEBREW_NO_AUTO_UPDATE=1

tmp_kde=/tmp/kde
dep_map="${tmp_kde}/dep_map"
bundle="${tmp_kde}/bundle"
install_order="${tmp_kde}/install_order"

rm -f "${dep_map}" "${install_order}" "${bundle}"
mkdir -p "${tmp_kde}"

formuladir="$(brew --repo kde-mac/kde)/Formula"

for formula in "${formuladir}"/*.rb; do
  formulaname=`basename "${formula}"`
  for dep in `grep "depends_on \"KDE-mac/kde" "${formula}" | awk -F "\"" '{print $2}'`; do
    echo "${dep/[k,K][d,D][e,E]-mac\/kde\//} ${formulaname//\.rb/}" >> "${dep_map}"
  done
done

tsort "${dep_map}" > "${install_order}" 2> /dev/null

echo 'tap "kde-mac/kde", "https://invent.kde.org/packaging/homebrew-kde.git"' > "${bundle}"

for candidate_formula in `cat "${install_order}"`; do
    formula_path="${formuladir}/${candidate_formula}.rb"
    if grep -E -L 'url "http|url "file' "${formula_path}" > /dev/null; then
		echo "brew \"KDE-mac/kde/${candidate_formula}\"" >> "${bundle}"
    else
		echo "brew \"KDE-mac/kde/${candidate_formula}\", args: [\"HEAD\"]" >> "${bundle}"
	fi
done

brew bundle --verbose --file "${bundle}"
