#!/bin/bash

brew update
export HOMEBREW_NO_AUTO_UPDATE=1

BREW_PERL_SEARCH='HOME/perl5'
PERL_ENV_CHEK='PERL5LIB'
BASH_PROFILE="${HOME}/.bash_profile"
ZSHRC="${HOME}/.zshrc"

if [[ -f "${ZSHRC}" ]] && grep -F "${BREW_PERL_SEARCH}" "${ZSHRC}" /dev/null ||
   [[ -f "${BASH_PROFILE}" ]] && grep -F "${BREW_PERL_SEARCH}" "${BASH_PROFILE}" /dev/null;
then
	echo
	echo "Your CPAN setup will not work with KDE, please remove line(-s) from corresponding file(-s) above."
	echo "Then re-run do-caveats.sh from new terminal session."
	exit -1
elif env | grep -q "${PERL_ENV_CHEK}";
then
	echo "Your CPAN setup will not work with KDE."
	echo "Please remove all perl-related stuff from your shell's profile"
	echo "Please don't report any perl-related bugs on kde-mac/kde, since they are out of scope of the project"
	exit -1
else
	echo "cpan good, continue"
fi

# cpan
if ! brew ls --formula| grep -q perl; then
    brew install perl
fi

export PERL_MM_USE_DEFAULT=1
cpan CPAN > /dev/null
cpan URI URI::Escape > /dev/null

# dbus
if ! brew ls --formula| grep -q dbus; then
    brew install dbus
fi

brew services start dbus

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
mkdir -p "$HOME/Applications/KDE"
rm -rf "$HOME/Applications/KDE*"
mkdir -p "$HOME/Library/Application Support/doc"
rm -rf "$HOME/Library/Application Support/doc/*"
ln -sf "$(brew --prefix)/share/doc/HTML" "$HOME/Library/Application Support/doc"
ln -sf "$(brew --prefix)/share/doc/qch" "$HOME/Library/Application Support/doc"
ln -sf "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/metainfo" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/config.kcfg" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/knotifycations5" "$HOME/Library/Application Support"
mkdir -p /usr/local/share/kxmlgui5
ln -sf "$(brew --prefix)/share/kxmlgui5" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/kpackage" "$HOME/Library/Application Support"
# kf5-breeze-icons
ln -sf "$(brew --prefix)/share/icons" "$HOME/Library/Application Support"
# kf5-kemoticons
ln -sf "$(brew --prefix)/share/emoticons" "$HOME/Library/Application Support"
# kf5-kparts
ln -sf "$(brew --prefix)/share/kdevappwizard" "$HOME/Library/Application Support"
# kf5-kdelibs4support
ln -sf "$(brew --prefix)/opt/kf5-kdelibs4support/bin/kdebugdialog5.app" "$HOME/Applications/KDE"
# kf5-plasma-frameworks
ln -sf "$(brew --prefix)/share/plasma" "$HOME/Library/Application Support"
# dolphin
ln -sf "$(brew --prefix)/share/dolphin" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/dolphin/bin/dolphin.app" "$HOME/Applications/KDE"
# kate
ln -sf "$(brew --prefix)/share/kate" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/kwrite" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/kateproject" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/katexmltools" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/kate/bin/kate.app" "$HOME/Applications/KDE"
ln -sf "$(brew --prefix)/opt/kate/bin/kwrite.app" "$HOME/Applications/KDE"
# kio-extras
ln -sf "$(brew --prefix)/share/kio_bookmarks" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/kio_info" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/konqsidebartng" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/konqueror" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/remoteview" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/solid" "$HOME/Library/Application Support"
# kmymoney
ln -sf "$(brew --prefix)/share/kmymoney" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/kmm_weboob" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/kmm_printcheck" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/kmymoney/bin/kmymoney.app" "$HOME/Applications/KDE"
# kolourpaint
ln -sf "$(brew --prefix)/share/kolourpaint" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/kolourpaint/bin/kolourpaint.app" "$HOME/Applications/KDE"
# konsole
ln -sf "$(brew --prefix)/share/konsole" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/konsole/bin/konsole.app" "$HOME/Applications/KDE"
# konversation
ln -sf "$(brew --prefix)/share/konversation" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/konversation/bin/konversation.app" "$HOME/Applications/KDE"
# lokalize
ln -sf "$(brew --prefix)/opt/lokalize/bin/lokalize.app" "$HOME/Applications/KDE"
# okteta
ln -sf "$(brew --prefix)/share/okteta" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/okteta/bin/okteta.app" "$HOME/Applications/KDE"
# kdevelop
ln -sf "$(brew --prefix)/share/kdevappwizard" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/kdevclangsupport" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/kdevcodeutils" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/kdevelop" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/kdevfiletemplates" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/kdevgdb" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/kdevmanpage" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/kdevqmakebuilder" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/share/kdevqmljssupport" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/kdevelop/bin/kdevelop.app" "$HOME/Applications/KDE"
# okular
ln -sf "$(brew --prefix)/share/okular" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/okular/bin/okular.app" "$HOME/Applications/KDE"
ln -sf "$(brew --prefix)/opt/okular/bin/okularkirigami.app" "$HOME/Applications/KDE"
# labplot
ln -sf "$(brew --prefix)/share/labplot2" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/labplot/bin/labplot2.app" "$HOME/Applications/KDE"
# kdenlive
ln -sf "$(brew --prefix)/share/kdenlive" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/kdenlive/bin/kdenlive.app" "$HOME/Applications/KDE"
# krename
ln -sf "$(brew --prefix)/share/krename" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/krename/bin/krename.app" "$HOME/Applications/KDE"
# ktorrent
ln -sf "$(brew --prefix)/share/ktorrent" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/ktorrent/bin/ktorrent.app" "$HOME/Applications/KDE"
ln -sf "$(brew --prefix)/opt/ktorrent/bin/ktupnptest.app" "$HOME/Applications/KDE"
# krusader
ln -sf "$(brew --prefix)/share/krusader" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/krusader/bin/krusader.app" "$HOME/Applications/KDE"
# elisa
ln -sf "$(brew --prefix)/opt/elisa/bin/elisa.app" "$HOME/Applications/KDE"
# kcalc
ln -sf "$(brew --prefix)/share/kcalc" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/kcalc/bin/kcalc.app" "$HOME/Applications/KDE"
# libksysguard
ln -sf "$(brew --prefix)/share/ksysguard" "$HOME/Library/Application Support"
# ksysguard
ln -sf "$(brew --prefix)/opt/ksysguard/bin/ksysguard.app" "$HOME/Applications/KDE"
# umbrello
ln -sf "$(brew --prefix)/share/umbrello5" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/umbrello/bin/umbrello5.app" "$HOME/Applications/KDE"
# atcore
ln -sf "$(brew --prefix)/opt/atcore/bin/AtCoreTest.app" "$HOME/Applications/KDE"
#kdeconnect
rm -rf "$HOME/Applications/KDE/kdeconnect.app"
ln -sf "$(brew --prefix)/opt/kdeconnect/bin/"*.app "$HOME/Applications/KDE"
#kf5-kjsembed
ln -sf "$(brew --prefix)/opt/kf5-kjsembed/bin/kjsconsole.app" "$HOME/Applications/KDE"
#kdialog
ln -sf "$(brew --prefix)/opt/kdialog/bin/kdialog.app" "$HOME/Applications/KDE"
ln -sf "$(brew --prefix)/opt/kdialog/bin/kdialog.app/Contents/MacOS/kdialog" "$(brew --prefix)/bin"
#kile
ln -sf "$(brew --prefix)/opt/kile/bin/Kile.app" "$HOME/Applications/KDE"
#tellico
ln -sf "$(brew --prefix)/share/tellico" "$HOME/Library/Application Support"
ln -sf "$(brew --prefix)/opt/tellico/bin/tellico.app" "$HOME/Applications/KDE"

echo "Caveats setup success"
exit 0
