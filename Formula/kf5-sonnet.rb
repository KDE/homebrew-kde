class Kf5Sonnet < Formula
  desc "Spelling framework for Qt5"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.70/sonnet-5.70.0.tar.xz"
  sha256 "1c0cbb3afe7d0e62c6524652626605d04bb9a49074e00d5ef61fd9c05d81082d"
  head "git://anongit.kde.org/sonnet.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "qt"

  depends_on "aspell" => :optional
  depends_on "hspell" => :optional
  depends_on "libvoikko" => :optional

  conflicts_with "hunspell", :because => "fatal error: 'hunspell.hxx' file not found"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
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

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Sonnet REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
