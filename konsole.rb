require "formula"

class Konsole < Formula
  desc "KDE's terminal emulator"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/applications/17.08.2/src/konsole-17.08.2.tar.xz"
  sha256 "02777e8bc545d2534ee97b25e745109fc084937050e6e4af9a5c9a6395d0f328"

  head "git://anongit.kde.org/konsole.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "kde-mac/kde/kf5-kdoctools" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kdbusaddons"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kcodecs"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kservice"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"
  depends_on "KDE-mac/kde/kf5-kwindowsystem"
  depends_on "KDE-mac/kde/kf5-kcrash"
  depends_on "KDE-mac/kde/kf5-sonnet"
  depends_on "KDE-mac/kde/kf5-karchive"
  depends_on "KDE-mac/kde/kf5-kitemmodels"
  depends_on "KDE-mac/kde/kf5-kauth"
  depends_on "KDE-mac/kde/kf5-kguiaddons"
  depends_on "KDE-mac/kde/kf5-kconfigwidgets"
  depends_on "KDE-mac/kde/kf5-kitemviews"
  depends_on "KDE-mac/kde/kf5-knotifications"
  depends_on "KDE-mac/kde/kf5-kjs"
  depends_on "KDE-mac/kde/kf5-kpty"
  depends_on "KDE-mac/kde/kf5-kjobwidgets"
  depends_on "KDE-mac/kde/kf5-kiconthemes"
  depends_on "KDE-mac/kde/kf5-kcompletion"
  depends_on "KDE-mac/kde/kf5-ktextwidgets"
  depends_on "KDE-mac/kde/kf5-kglobalaccel"
  depends_on "KDE-mac/kde/kf5-attica"
  depends_on "KDE-mac/kde/kf5-kxmlgui"
  depends_on "KDE-mac/kde/kf5-solid"
  depends_on "KDE-mac/kde/kf5-kwallet"
  depends_on "KDE-mac/kde/kf5-kbookmarks"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kunitconversion"
  depends_on "KDE-mac/kde/kf5-knotifyconfig"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-kross"
  depends_on "KDE-mac/kde/kf5-kinit"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{prefix}/bin"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work (NOTE: the order is important!):
      ln -sf "$(brew --prefix)/share/konsole" ~/Library/"Application Support"
      ln -sf "$(brew --prefix)/share/icons/breeze/breeze-icons.rcc" ~/Library/"Application Support"/konsole/icontheme.rcc
      mkdir -p ~/Applications/KDE
      ln -sf "#{prefix}/bin/konsole.app" ~/Applications/KDE/
    EOS
  end
end
