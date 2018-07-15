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
ln -sfv "$(brew --cellar)/kf5-kdelibs4support/5.48.0/bin/kdebugdialog5.app" "$HOME/Applications/KDE/"
# dolphin
ln -sfv "$(brew --cellar)/dolphin/18.04.3/bin/dolphin" "$HOME/Applications/KDE/"
# kate
ln -sfv "$(brew --cellar)/kate/18.04.3/bin/kate.app" "$HOME/Applications/KDE/"
ln -sfv "$(brew --cellar)/kwrite/18.04.3/bin/kwrite.app" "$HOME/Applications/KDE/"
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
ln -sfv "$(brew --cellar)/kmymoney/5.0.1/bin/kmymoney.app" "$HOME/Applications/KDE/"
# kolourpaint
ln -sfv "$(brew --prefix)/share/kolourpaint" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kxmlgui5" "$HOME/Library/Application Support"
ln -sfv "$(brew --cellar)/kolourpaint/18.04.3/bin/kolourpaint.app" "$HOME/Applications/KDE/"
# konsole
ln -sfv "$(brew --prefix)/share/konsole" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/knotifications5" "$HOME/Library/Application Support"
ln -sfv "$(brew --cellar)/konsole/18.04.3/bin/konsole.app" "$HOME/Applications/KDE/"
# konversation
ln -sfv "$(brew --prefix)/share/konversation" "$HOME/Library/Application Support"
ln -sfv "$(brew --cellar)/konversation/1.7.5/bin/konversation.app" "$HOME/Applications/KDE/"
# lokalize
ln -sfv "$(brew --prefix)/opt/lokalize/bin/lokalize.app" "$HOME/Applications/KDE/"
# okteta
ln -sfv "$(brew --prefix)/share/okteta" "$HOME/Library/Application Support"
ln -sfv "$(brew --cellar)/okteta/0.25.1/bin/okteta.app" "$HOME/Applications/KDE/"
# poxml
ln -sfv "$(brew --prefix)/opt/poxml/bin/po2xml.app" "$HOME/Applications/KDE/"
ln -sfv "$(brew --prefix)/opt/poxml/bin/split2po.app" "$HOME/Applications/KDE/"
ln -sfv "$(brew --prefix)/opt/poxml/bin/swappo.app" "$HOME/Applications/KDE/"
ln -sfv "$(brew --prefix)/opt/poxml/bin/xml2pot.app" "$HOME/Applications/KDE/"
# elisa
ln -sfv "$(brew --cellar)/elisa/0.2.1/bin/konversation.app" "$HOME/Applications/KDE/"
# kdevelop
ln -sfv "$(brew --cellar)/kdevelop/5.2.3/bin/kdevelop.app" "$HOME/Applications/KDE/"
#okular
ln -sfv "$(brew --prefix)/share/okular" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/metainfo" "$HOME/Library/Application Support"
#labplot
ln -sfv "$(brew --prefix)/share/labplot2" "$HOME/Library/Application Support"
ln -sfv "$(brew --cellar)/labplot/2.5.0/bin/labplot2.app" "$HOME/Applications/KDE"
ln -sfv "$(brew --cellar)/labplot/2.5.0/share/kxmlgui5/labplot2/labplot2ui.rc" "$(brew --cellar)/labplot/2.5.0/bin/labplot2.app/Contents/Resources"