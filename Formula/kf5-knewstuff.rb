require_relative "../lib/cmake"

class Kf5Knewstuff < Formula
  desc "Support for downloading application assets from the network"
  homepage "https://api.kde.org/frameworks/knewstuff/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.80/knewstuff-5.80.0.tar.xz"
  sha256 "dfe874f7fe944fe877c0d443349102ceacb268c45dc1f666ec42ff219024735d"
  head "https://invent.kde.org/frameworks/knewstuff.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-kirigami2"
  depends_on "kde-mac/kde/kf5-kpackage"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      find_package(ECM REQUIRED)
      set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})
      find_package(KF5NewStuff REQUIRED)
      find_package(KF5NewStuffCore REQUIRED)
      find_package(KF5NewStuffQuick REQUIRED)
    EOS

    args = kde_cmake_args

    args << "-DQt5Widgets_DIR=#{Formula["qt"].opt_prefix/"lib/cmake/Qt5Widgets"}"
    args << "-DQt5Xml_DIR=#{Formula["qt"].opt_prefix/"lib/cmake/Qt5Xml"}"
    args << "-DQt5Network_DIR=#{Formula["qt"].opt_prefix/"lib/cmake/Qt5Network"}"

    system "cmake", ".", *args
  end
end
