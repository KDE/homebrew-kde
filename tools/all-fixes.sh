# cpanm
brew install cpanminus
cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
cpanm --local-lib=~/perl5 URI::Escape && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
cpanm --local-lib=~/perl5 URI && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)

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
ln -sfv "$(brew --cellar)/kdebugdialog5/18.04.3/bin/kdebugdialog5.app" $HOME/Applications/KDE/
# dolphin
ln -sfv "$(brew --cellar)/dolphin/18.04.3/bin/dolphin" "$HOME/Library/Application Support"
# kate
ln -sfv "$(brew --cellar)/kate/18.04.3/bin/kate.app" $HOME/Applications/KDE/
ln -sfv "$(brew --cellar)/kwrite/18.04.3/bin/kwrite.app" $HOME/Applications/KDE/
# kf5-kross
ln -sfv "$(brew --prefix)/opt/kf5-kross/bin/kf5kross.app" $HOME/Applications/KDE/
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
ln -sfv "$(brew --cellar)/kdebugdialog5/18.04.3/bin/kmymoney.app" $HOME/Applications/KDE/
# kolourpaint
ln -sfv "$(brew --prefix)/share/kolourpaint" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/kxmlgui5" "$HOME/Library/Application Support"
# konsole
ln -sfv "$(brew --prefix)/share/konsole" "$HOME/Library/Application Support"
ln -sfv "$(brew --prefix)/share/knotifications5" "$HOME/Library/Application Support"
ln -sfv "$(brew --cellar)/konsole/18.04.3/bin/konsole.app" $HOME/Applications/KDE/
# konversation
ln -sfv "$(brew --prefix)/share/konversation" "$HOME/Library/Application Support"
ln -sfv "$(brew --cellar)/konversation/18.04.3//bin/konversation.app" $HOME/Applications/KDE/
# lokalize
ln -sfv "$(brew --prefix)/opt/lokalize/bin/lokalize.app" $HOME/Applications/KDE/
# okteta
ln -sfv "$(brew --prefix)/share/okteta" "$HOME/Library/Application Support"
ln -sfv "$(brew --cellar)/okteta/18.04.3/bin/okteta.app" $HOME/Applications/KDE/
# poxml
ln -sfv "$(brew --prefix)/opt/poxml/bin/po2xml.app" $HOME/Applications/KDE/
ln -sfv "$(brew --prefix)/opt/poxml/bin/split2po.app" $HOME/Applications/KDE/
ln -sfv "$(brew --prefix)/opt/poxml/bin/swappo.app" $HOME/Applications/KDE/
ln -sfv "$(brew --prefix)/opt/poxml/bin/xml2pot.app" $HOME/Applications/KDE/