#!/bin/bash

brew update
HOMEBREW_NO_AUTO_UPDATE=1

if ! brew ls --formula| grep -q dbus; then
    brew install dbus
fi

brew services restart dbus

MIGRATED=(
	extra-cmake-modules
	karchive
	kdoctools
	ki18n
	threadweaver
)

for FORMULA in "${MIGRATED[@]}"; do
	if brew ls --formula | grep -q kf5-"${FORMULA}"; then
    	brew uninstall -f --ignore-dependencies kf5-"${FORMULA}"
    	brew install kde-"${FORMULA}"
    	brew link kde-"${FORMULA}"
	fi
done

BROKEN_LINK=(
	okteta
)

for FORMULA in "${BROKEN_LINK[@]}"; do
	if brew ls --formula | grep -q "${FORMULA}"; then
    	brew link --overwrite "${FORMULA}"
	fi
done

# common
HOME_APPS_KDE="${HOME}/Applications/KDE"
APPLICATION_SUPPORT="${HOME}/Library/Application Support"
APPLICATION_SUPPORT_DOC="${APPLICATION_SUPPORT}/doc"
mkdir -p "${HOME_APPS_KDE}"
mkdir -p "${APPLICATION_SUPPORT_DOC}"
ln -sf "$(brew --prefix)/share/doc/HTML" "${APPLICATION_SUPPORT_DOC}"
ln -sf "$(brew --prefix)/share/doc/qch" "${APPLICATION_SUPPORT_DOC}"
ln -sf "$(brew --prefix)/share/kf5" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/kservices5" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/metainfo" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/kservicetypes5" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/config.kcfg" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/knotifycations5" "${APPLICATION_SUPPORT}"
mkdir -p "$(brew --prefix)/share/kxmlgui5"
ln -sf "$(brew --prefix)/share/kxmlgui5" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/kpackage" "${APPLICATION_SUPPORT}"
# kf5-breeze-icons
ln -sf "$(brew --prefix)/share/icons" "${APPLICATION_SUPPORT}"
# kf5-kemoticons
ln -sf "$(brew --prefix)/share/emoticons" "${APPLICATION_SUPPORT}"
# kf5-kparts
ln -sf "$(brew --prefix)/share/kdevappwizard" "${APPLICATION_SUPPORT}"
# kf5-kdelibs4support
ln -sf "$(brew --prefix)/opt/kf5-kdelibs4support/bin/kdebugdialog5.app" "${HOME_APPS_KDE}"
# dolphin
ln -sf "$(brew --prefix)/share/dolphin" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/dolphin/bin/dolphin.app" "${HOME_APPS_KDE}"
# kate
ln -sf "$(brew --prefix)/share/kate" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/kwrite" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/kateproject" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/katexmltools" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/kate/bin/kate.app" "${HOME_APPS_KDE}"
ln -sf "$(brew --prefix)/opt/kate/bin/kwrite.app" "${HOME_APPS_KDE}"
# kio-extras
ln -sf "$(brew --prefix)/share/kio_bookmarks" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/kio_info" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/konqsidebartng" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/konqueror" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/remoteview" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/solid" "${APPLICATION_SUPPORT}"
# kmymoney
ln -sf "$(brew --prefix)/share/kmymoney" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/kmm_weboob" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/kmm_printcheck" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/kmymoney/bin/kmymoney.app" "${HOME_APPS_KDE}"
# kolourpaint
ln -sf "$(brew --prefix)/share/kolourpaint" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/kolourpaint/bin/kolourpaint.app" "${HOME_APPS_KDE}"
# konsole
ln -sf "$(brew --prefix)/share/konsole" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/konsole/bin/konsole.app" "${HOME_APPS_KDE}"
# konversation
ln -sf "$(brew --prefix)/share/konversation" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/konversation/bin/konversation.app" "${HOME_APPS_KDE}"
# lokalize
ln -sf "$(brew --prefix)/opt/lokalize/bin/lokalize.app" "${HOME_APPS_KDE}"
# okteta
ln -sf "$(brew --prefix)/share/okteta" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/okteta/bin/okteta.app" "${HOME_APPS_KDE}"
# kdevelop
ln -sf "$(brew --prefix)/share/kdevappwizard" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/kdevclangsupport" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/kdevcodeutils" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/kdevelop" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/kdevfiletemplates" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/kdevgdb" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/kdevmanpage" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/kdevqmakebuilder" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/share/kdevqmljssupport" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/kdevelop/bin/kdevelop.app" "${HOME_APPS_KDE}"
# okular
ln -sf "$(brew --prefix)/share/okular" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/okular/bin/okular.app" "${HOME_APPS_KDE}"
rm -f "${HOME_APPS_KDE}/okularkirigami.app" #doesn't being shipped anymore
# labplot
ln -sf "$(brew --prefix)/share/labplot2" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/labplot/bin/labplot2.app" "${HOME_APPS_KDE}"
# kdenlive
ln -sf "$(brew --prefix)/share/kdenlive" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/kdenlive/bin/kdenlive.app" "${HOME_APPS_KDE}"
# krename
ln -sf "$(brew --prefix)/share/krename" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/krename/bin/krename.app" "${HOME_APPS_KDE}"
# ktorrent
ln -sf "$(brew --prefix)/share/ktorrent" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/ktorrent/bin/ktorrent.app" "${HOME_APPS_KDE}"
ln -sf "$(brew --prefix)/opt/ktorrent/bin/ktupnptest.app" "${HOME_APPS_KDE}"
# krusader
ln -sf "$(brew --prefix)/share/krusader" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/krusader/bin/krusader.app" "${HOME_APPS_KDE}"
# elisa
ln -sf "$(brew --prefix)/opt/elisa/bin/elisa.app" "${HOME_APPS_KDE}"
# kcalc
ln -sf "$(brew --prefix)/share/kcalc" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/kcalc/bin/kcalc.app" "${HOME_APPS_KDE}"
# libksysguard
ln -sf "$(brew --prefix)/share/ksysguard" "${APPLICATION_SUPPORT}"
# ksysguard
ln -sf "$(brew --prefix)/opt/ksysguard/bin/ksysguard.app" "${HOME_APPS_KDE}"
# umbrello
ln -sf "$(brew --prefix)/share/umbrello5" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/umbrello/bin/umbrello5.app" "${HOME_APPS_KDE}"
# atcore
ln -sf "$(brew --prefix)/opt/atcore/bin/AtCoreTest.app" "${HOME_APPS_KDE}"

#kdeconnect
rm -f "${HOME_APPS_KDE}"/\*.app
KDE_CONNECT_APPS=(
	kdeconnect-app.app
	kdeconnect-handler.app
	kdeconnect-indicator.app
	kdeconnect-settings.app
	kdeconnect-sms.app
)
for KDE_CONNECT_APP in "${KDE_CONNECT_APPS[@]}"; do
	ln -sf "$(brew --prefix)/opt/kdeconnect/bin/${KDE_CONNECT_APP}" "${HOME_APPS_KDE}"
done

#kf5-kjsembed
ln -sf "$(brew --prefix)/opt/kf5-kjsembed/bin/kjsconsole.app" "${HOME_APPS_KDE}"
#kdialog
ln -sf "$(brew --prefix)/opt/kdialog/bin/kdialog.app" "${HOME_APPS_KDE}"
ln -sf "$(brew --prefix)/opt/kdialog/bin/kdialog.app/Contents/MacOS/kdialog" "$(brew --prefix)/bin"
#kile
ln -sf "$(brew --prefix)/opt/kile/bin/Kile.app" "${HOME_APPS_KDE}"
#tellico
ln -sf "$(brew --prefix)/share/tellico" "${APPLICATION_SUPPORT}"
ln -sf "$(brew --prefix)/opt/tellico/bin/tellico.app" "${HOME_APPS_KDE}"
#kdiff3
ln -sf "$(brew --prefix)/opt/kdiff3/bin/kdiff3.app" "${HOME_APPS_KDE}"

echo "Caveats setup success"
exit 0
