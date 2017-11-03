require "formula"

class Kdevelop < Formula
  desc "Integrated Development Environment for KDE"
  homepage "http://kdevelop.org"

  stable do
    url "https://download.kde.org/stable/kdevelop/5.1.2/src/kdevelop-5.1.2.tar.xz"
    sha256 "af54e807847d145fe5f3eb55962ed0d22e6363c2bc6c32167e51ca4823c00ac7"
    depends_on "KDE-mac/kde/kdevplatform"
  end

  head "git://anongit.kde.org/kdevelop.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "KDE-mac/kde/kdevelop-pg-qt" => :build
  depends_on "KDE-mac/kde/okteta" => :optional

  depends_on "qt"
  depends_on "llvm"
  depends_on "KDE-mac/kde/kf5-karchive"
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kguiaddons"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kiconthemes"
  depends_on "KDE-mac/kde/kf5-kinit"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kitemmodels"
  depends_on "KDE-mac/kde/kf5-kitemviews"
  depends_on "KDE-mac/kde/kf5-kjobwidgets"
  depends_on "KDE-mac/kde/kf5-knewstuff"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-kservice"
  depends_on "KDE-mac/kde/kf5-ktexteditor"
  depends_on "KDE-mac/kde/kf5-kwallet"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"
  depends_on "KDE-mac/kde/kf5-kwindowsystem"
  depends_on "KDE-mac/kde/kf5-kxmlgui"
  depends_on "KDE-mac/kde/kf5-sonnet"
  depends_on "KDE-mac/kde/kf5-breeze-icons"

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
      You need to make sime manual steps in order to make this formula work:
        mkdir -p ~/Library/"Application Support"/kdevelop
        ln -sf "$(brew --prefix)/share/icons/breeze/breeze-icons.rcc" ~/Library/"Application Support"/kdevelop/icontheme.rcc
        mkdir -p ~/Applications/KDE
        ln -sf "#{prefix}/bin/kdevelop.app" ~/Applications/KDE/
        ln -sf "#{prefix}/bin/kdev_includepathsconverter.app" ~/Applications/KDE/
        ln -sf "#{prefix}/bin/kdevelop\!" ~/Applications/KDE/
      EOS
  end
end
