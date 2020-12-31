class Kf5Sonnet < Formula
  desc "Spelling framework for Qt5"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.77/sonnet-5.77.0.tar.xz"
  sha256 "d092461a6a86811ab749459cc2079903616d4f839e73762b60019b5454db9068"
  head "https://invent.kde.org/frameworks/sonnet.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "hunspell"
  depends_on "qt"

  depends_on "aspell" => :optional
  depends_on "hspell" => :optional
  depends_on "libvoikko" => :optional

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
