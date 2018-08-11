# cpan
brew install perl
export PERL_MM_USE_DEFAULT=1
cpan URI URI::Escape
# common
mkdir -pv "$HOME/Applications/KDE"
rm -rfv "$HOME/Applications/KDE/*"
ln -sfv "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kate" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kwrite" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kateproject" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/katexmltools" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/metainfo" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/plasma" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/config.kcfg" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/knotifycations5" "$HOME/Library/Application Support"
# kf5-breeze-icons
ln -sfv "$(brew --prefix)/share/icons" "$HOME/Library/Application Support"
# kf5-kemoticons
ln -sfv "$(brew --prefix)/share/emoticons" "$HOME/Library/Application Support"
# kf5-kparts
ln -sfv "$(brew --prefix)/share/kdevappwizard" "$HOME/Library/Application Support"
# kf5-kdelibs4support
ln -sfv "$(brew --cellar)/kf5-kdelibs4support/5.49.0/bin/kdebugdialog5.app" "$HOME/Applications/KDE/"
# dolphin
ln -sfv "$(brew --prefix)/opt/dolphin/bin/dolphin.app" "$HOME/Applications/KDE/"
# kate
ln -sfv "$(brew --prefix)/opt/kate/bin/kate.app" "$HOME/Applications/KDE/"
ln -sfv "$(brew --prefix)/opt/kwrite/bin/kwrite.app" "$HOME/Applications/KDE/"
# kf5-kross
ln -sfv "$(brew --prefix)/opt/kf5-kross/bin/kf5kross.app" "$HOME/Applications/KDE/"
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
ln -sfv "$(brew --prefix)/share/kconf_update" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/kmymoney/bin/kmymoney.app" "$HOME/Applications/KDE/"
# kolourpaint
ln -sfv "$(brew --prefix)/share/kolourpaint" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kxmlgui5" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/kolourpaint/bin/kolourpaint.app" "$HOME/Applications/KDE/"
# konsole
ln -sfv "$(brew --prefix)/share/konsole" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/knotifications5" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/konsole/bin/konsole.app" "$HOME/Applications/KDE/"
# konversation
ln -sfv "$(brew --prefix)/share/konversation" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/konversation/bin/konversation.app" "$HOME/Applications/KDE/"
# lokalize
ln -sfv "$(brew --prefix)/opt/lokalize/bin/lokalize.app" "$HOME/Applications/KDE/"
# okteta
ln -sfv "$(brew --prefix)/share/okteta" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/okteta/bin/okteta.app" "$HOME/Applications/KDE/"
# poxml
ln -sfv "$(brew --prefix)/opt/poxml/bin/po2xml.app" "$HOME/Applications/KDE/"
ln -sfv "$(brew --prefix)/opt/poxml/bin/split2po.app" "$HOME/Applications/KDE/"
ln -sfv "$(brew --prefix)/opt/poxml/bin/swappo.app" "$HOME/Applications/KDE/"
ln -sfv "$(brew --prefix)/opt/poxml/bin/xml2pot.app" "$HOME/Applications/KDE/"
# elisa
ln -sfv "$(brew --prefix)/opt/elisa/bin/elisa.app" "$HOME/Applications/KDE/"
# kdevelop
ln -sfv "$(brew --prefix)/opt/kdevelop/bin/kdevelop.app" "$HOME/Applications/KDE/"
#okular
ln -sfv "$(brew --prefix)/share/okular" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/metainfo" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/opt/okular/bin/okular.app" "$HOME/Applications/KDE/"
#labplot
ln -sfv "$(brew --prefix)/share/labplot2" "$HOME/Library/Application Support"
[ -d "$(brew --prefix)/opt/labplot/bin/labplot2.app" ] && \
	ln -sfv "$(brew --prefix)/opt/labplot/bin/labplot2.app" "/Applications"
[ -d "$(brew --prefix)/opt/labplot/bin/labplot2.app/Contents/Resources" ] && \
	ln -sfv "$(brew --prefix)/opt/labplot/share/kxmlgui5/labplot2/labplot2ui.rc" \
	"$(brew --prefix)/opt/labplot/bin/labplot2.app/Contents/Resources"
#kdenlive
ln -sfv "$(brew --prefix)/share/kdenlive" "$HOME/Library/Application Support"
ln -sfv "$(brew --cellar)/kdenlive/18.04.3/bin/kdenlive.app" "$HOME/Applications/KDE"

exit 0