class Kf5Kded < Formula
  desc "Extensible deamon for providing system level services"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.67/kded-5.67.0.tar.xz"
  sha256 "71229aaaf37aa3c6ca85c692c873fcbf6902da52d1ce0ca92404f84bf7b4a7b7"
  head "git://anongit.kde.org/kded.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kinit"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DKDE_INSTALL_QTPLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
  EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KDED REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
