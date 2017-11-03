require "formula"

class Konversation < Formula
  desc "A user-friendly and fully-featured IRC client"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/konversation/1.7.2/src/konversation-1.7.2.tar.xz"
  sha256 "5ff96e84cee4e1eefc404a31d778067ea50dddd8a6c848911fac70bd52812618"

  head "git://anongit.kde.org/konversation.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "qca"
  depends_on "KDE-mac/kde/kf5-karchive"
  depends_on "KDE-mac/kde/kf5-kbookmarks"
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kconfigwidgets"
  depends_on "KDE-mac/kde/kf5-kdoctools"
  depends_on "KDE-mac/kde/kf5-kemoticons"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kidletime"
  depends_on "KDE-mac/kde/kf5-knotifyconfig"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-solid"
  depends_on "KDE-mac/kde/kf5-sonnet"
  depends_on "KDE-mac/kde/kf5-kwallet"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"
  depends_on "KDE-mac/kde/kf5-kglobalaccel"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{prefix}/bin"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work (NOTE: the order is important!):
      ln -sf "$(brew --prefix)/share/konversation ~/Library/"Application Support"
      ln -sf "$(brew --prefix)/share/icons/breeze/breeze-icons.rcc" ~/Library/"Application Support"/konversation/icontheme.rcc
      mkdir -p ~/Applications/KDE
      ln -sf "#{prefix}/bin/konversation.app" ~/Applications/KDE/
    EOS
  end
end
