#!/usr/bin/env bash

# cpan
brew install perl dbus
export PERL_MM_USE_DEFAULT=1
cpan CPAN
cpan URI URI::Escape
brew services start dbus
# common
mkdir -pv "$HOME/Applications/KDE"
rm -rfv "$HOME/Applications/KDE*"
mkdir -pv "$HOME/Library/Application Support/doc"
rm -rfv "$HOME/Library/Application Support/doc/*"
ln -sfv "$(brew --prefix)/share/doc/HTML" "$HOME/Library/Application Support/doc"
ln -sfv "$(brew --prefix)/share/doc/qch" "$HOME/Library/Application Support/doc"
ln -sfv "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/metainfo" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/config.kcfg" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/knotifycations5" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kxmlgui5" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kpackage" "$HOME/Library/Application Support"
# kf5-breeze-icons
ln -sfv "$(brew --prefix)/share/icons" "$HOME/Library/Application Support"
# kf5-kemoticons
ln -sfv "$(brew --prefix)/share/emoticons" "$HOME/Library/Application Support"
# kf5-kparts
ln -sfv "$(brew --prefix)/share/kdevappwizard" "$HOME/Library/Application Support"
# kf5-kdelibs4support
ln -sfv "$(brew --prefix)/opt/kf5-kdelibs4support/bin/kdebugdialog5.app" "$HOME/Applications/KDE"
# kf5-plasma-frameworks
ln -sfv "$(brew --prefix)/share/plasma" "$HOME/Library/Application Support"
# dolphin
ln -sfv "$(brew --prefix)/share/dolphin" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/dolphin/bin/dolphin.app" "$HOME/Applications/KDE"
# kate
ln -sfv "$(brew --prefix)/share/kate" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kwrite" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kateproject" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/katexmltools" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/kate/bin/kate.app" "$HOME/Applications/KDE"
ln -sfv "$(brew --prefix)/opt/kate/bin/kwrite.app" "$HOME/Applications/KDE"
# kio-extras
ln -sfv "$(brew --prefix)/share/kio_bookmarks" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kio_info" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/konqsidebartng" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/konqueror" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/remoteview" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/solid" "$HOME/Library/Application Support"
# kmymoney
ln -sfv "$(brew --prefix)/share/kmymoney" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kmm_weboob" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kmm_printcheck" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/kmymoney/bin/kmymoney.app" "$HOME/Applications/KDE"
# kolourpaint
ln -sfv "$(brew --prefix)/share/kolourpaint" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/kolourpaint/bin/kolourpaint.app" "$HOME/Applications/KDE"
# konsole
ln -sfv "$(brew --prefix)/share/konsole" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/konsole/bin/konsole.app" "$HOME/Applications/KDE"
# konversation
ln -sfv "$(brew --prefix)/share/konversation" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/konversation/bin/konversation.app" "$HOME/Applications/KDE"
# lokalize
ln -sfv "$(brew --prefix)/opt/lokalize/bin/lokalize.app" "$HOME/Applications/KDE"
# okteta
ln -sfv "$(brew --prefix)/share/okteta" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/okteta/bin/okteta.app" "$HOME/Applications/KDE"
# kdevelop
ln -sfv "$(brew --prefix)/share/kdevappwizard" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kdevclangsupport" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kdevcodeutils" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kdevelop" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kdevfiletemplates" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kdevgdb" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kdevmanpage" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kdevqmakebuilder" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kdevqmljssupport" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/kdevelop/bin/kdevelop.app" "$HOME/Applications/KDE"
# okular
ln -sfv "$(brew --prefix)/share/okular" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/okular/bin/okular.app" "$HOME/Applications/KDE"
# labplot
ln -sfv "$(brew --prefix)/share/labplot2" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/labplot/bin/labplot2.app" "/Applications/KDE"
# kdenlive
ln -sfv "$(brew --prefix)/share/kdenlive" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/kdenlive/bin/kdenlive.app" "$HOME/Applications/KDE"
# krename
ln -sfv "$(brew --prefix)/share/krename" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/krename/bin/krename.app" "$HOME/Applications/KDE"
# ktorrent
ln -sfv "$(brew --prefix)/share/ktorrent" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/ktorrent/bin/ktorrent.app" "$HOME/Applications/KDE"
ln -sfv "$(brew --prefix)/opt/ktorrent/bin/ktupnptest.app" "$HOME/Applications/KDE"
# krusader
ln -sfv "$(brew --prefix)/share/krusader" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/krusader/bin/krusader.app" "$HOME/Applications/KDE"
# elisa
ln -sfv "$(brew --prefix)/opt/elisa/bin/elisa.app" "$HOME/Applications/KDE"
# kcalc
ln -sfv "$(brew --prefix)/share/kcalc" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/kcalc/bin/kcalc.app" "$HOME/Applications/KDE"
# libksysguard
ln -sfv "$(brew --prefix)/share/ksysguard" "$HOME/Library/Application Support"
# ksysguard
ln -sfv "$(brew --prefix)/opt/ksysguard/bin/ksysguard.app" "$HOME/Applications/KDE"
# umbrello
ln -sfv "$(brew --prefix)/share/umbrello5" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/umbrello/bin/umbrello5.app" "$HOME/Applications/KDE"
# atcore
ln -sfv "$(brew --prefix)/opt/atcore/bin/AtCoreTest.app" "$HOME/Applications/KDE"

exit 0
