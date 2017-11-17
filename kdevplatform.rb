class Kdevplatform < Formula
  desc "KDevelop Platform"
  homepage "https://kdevelop.org"
  url "https://download.kde.org/stable/kdevelop/5.1.2/src/kdevplatform-5.1.2.tar.xz"
  sha256 "e622ddad552a678baaf1166d5cbdc5fd1192d2324300c52ef2d25f1c6778664a"

  head "git://anongit.kde.org/kdevplatform.git"

  depends_on "cmake" => :build
  depends_on "boost" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-kitemmodels"
  depends_on "KDE-mac/kde/kf5-knewstuff"
  depends_on "KDE-mac/kde/kf5-knotifyconfig"
  depends_on "KDE-mac/kde/kf5-ktexteditor"
  depends_on "KDE-mac/kde/kf5-threadweaver"
  depends_on "KDE-mac/kde/qt-webkit"
  depends_on "KDE-mac/kde/grantlee5"
  depends_on "KDE-mac/kde/libkomparediff2"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DQt5WebKitWidgets_DIR=#{HOMEBREW_PREFIX}/lib/cmake/Qt5WebKitWidgets"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kdevcodeutils" "$HOME/Library/Application Support"
      ln -sf "$(brew --prefix)/share/kkdevcodegen" "$HOME/Library/Application Support"
    EOS
  end
end
