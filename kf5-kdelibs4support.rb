require "formula"

class Kf5Kdelibs4support < Formula
  desc "Porting aid from KDELibs4"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/portingAids/kdelibs4support-5.39.0.tar.xz"
  sha256 "d735000260d8565e812b96c81d510acef14f7b66e9fcbbd2d42711bd1bfcb20f"

  head "git://anongit.kde.org/kdelibs4support.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdesignerplugin" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "qt"
  depends_on "openssl@1.1"
  depends_on "KDE-mac/kde/kf5-kded"
  depends_on "KDE-mac/kde/kf5-kemoticons"
  depends_on "KDE-mac/kde/kf5-kinit"
  depends_on "KDE-mac/kde/kf5-kitemmodels"
  depends_on "KDE-mac/kde/kf5-kunitconversion"
  depends_on "KDE-mac/kde/kf5-kparts"

  patch do
    url "https://git.archlinux.org/svntogit/packages.git/plain/trunk/kdelibs4support-openssl-1.1.patch?h=packages/kdelibs4support"
    sha256 "e33de96fae2b93c3fa06b4219205ae188b214be8c5e84b8d0426217fd65a5d48"
  end

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
    You need to take some manual steps in order to make this formula work:
      mkdir -p ~/Applications/KDE
      ln -sf "#{prefix}/bin/kdebugdialog5.app" ~/Applications/KDE/
    EOS
  end
end
