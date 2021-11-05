#!/bin/bash

HOMEBREW_NO_AUTO_UPDATE=1
INSTALLED_FORMULAS_LIST=/tmp/kde/installed
mkdir -p /tmp/kde/

brew ls --formula --full-name > "${INSTALLED_FORMULAS_LIST}"

if grep -q '^kde-mac/kde' "${INSTALLED_FORMULAS_LIST}"; then
	echo "Uninstalling formulas from kde-mac/kde tap"
	brew uninstall -f `grep '^kde-mac/kde' "${INSTALLED_FORMULAS_LIST}"`
else
	echo "No formulas from kde-mac/kde tap is installed"
fi

CORE_FORMULAS=(
	threadweaver
	kdoctools
	ki18n
	karchive
	extra-cmake-modules
)

echo "Removing kde formulas from homebrew/core if any installed"

for CORE_FORMULA in "${CORE_FORMULAS[@]}"; do
	if grep -q "${CORE_FORMULA}" "${INSTALLED_FORMULAS_LIST}"; then
		brew uninstall -f --formula "${CORE_FORMULA}"
	fi
done

rm "${INSTALLED_FORMULAS_LIST}"
# echo "Cleaning ~/Applications/KDE"
# rm -rf "${HOME}"/Applications/KDE
