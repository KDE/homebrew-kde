#!/bin/sh -e

# Phonon is not really part of KF5, install first
pre="haraldf/kf5/kf5-extra-cmake-modules
     haraldf/kf5/kf5-phonon "

# kf5-threadweaver

tier1="
    haraldf/kf5/kf5-kjs
    haraldf/kf5/kf5-karchive
    haraldf/kf5/kf5-solid
    haraldf/kf5/kf5-kwidgetsaddons
    haraldf/kf5/kf5-kcoreaddons
    haraldf/kf5/kf5-kcodecs
    haraldf/kf5/kf5-kconfig
    haraldf/kf5/kf5-kitemviews
    haraldf/kf5/kf5-umbrella
    haraldf/kf5/kf5-kguiaddons
    haraldf/kf5/kf5-kwindowsystem
    haraldf/kf5/kf5-sonnet
    haraldf/kf5/kf5-kitemmodels
    haraldf/kf5/kf5-kdbusaddons
    haraldf/kf5/kf5-kimageformats
    haraldf/kf5/kf5-kplotting
    haraldf/kf5/kf5-kidletime"

tier2="
    haraldf/kf5/kf5-kcompletion
    haraldf/kf5/kf5-kjobwidgets
    haraldf/kf5/kf5-kauth
    haraldf/kf5/kf5-kcrash
    haraldf/kf5/kf5-kdoctools
    haraldf/kf5/kf5-ki18n
    haraldf/kf5/kf5-kservice
    haraldf/kf5/kf5-kconfigwidgets
    haraldf/kf5/kf5-kiconthemes
    haraldf/kf5/kf5-knotifications
    haraldf/kf5/kf5-kwallet"

#    haraldf/kf5/kf5-ktexteditor ### KF 5.1

others="
    haraldf/kf5/kf5-attica
    haraldf/kf5/kf5-kglobalaccel
    haraldf/kf5/kf5-ktextwidgets
    haraldf/kf5/kf5-kxmlgui
    haraldf/kf5/kf5-kbookmarks
    haraldf/kf5/kf5-kdesignerplugin
    haraldf/kf5/kf5-kemoticons
    haraldf/kf5/kf5-kio
    haraldf/kf5/kf5-kinit
    haraldf/kf5/kf5-knewstuff
    haraldf/kf5/kf5-knotifyconfig
    haraldf/kf5/kf5-kparts
    haraldf/kf5/kf5-kpty
    haraldf/kf5/kf5-kross
    haraldf/kf5/kf5-kunitconversion
    haraldf/kf5/kf5-kde4support"

brew install --verbose $pre

brew install --verbose $tier1

brew install --verbose $tier2

brew install --verbose $others
