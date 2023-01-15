require_relative "../lib/cmake"

class Kf5Knewstuff < Formula
  desc "Support for downloading application assets from the network"
  homepage "https://api.kde.org/frameworks/knewstuff/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.102/knewstuff-5.102.0.tar.xz"
  sha256 "e5bf319cfff478d37c27ea096d76d25fd6c3bd8eeeebc94ca507db78dd26fc88"
  head "https://invent.kde.org/frameworks/knewstuff.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-kirigami2"
  depends_on "kde-mac/kde/kf5-kpackage"

  def install
    system "cmake", *kde_cmake_args
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

    args = %W[
      -DQt5Widgets_DIR=#{Formula["qt@5"].opt_prefix}/lib/cmake/Qt5Widgets
      -DQt5Xml_DIR=#{Formula["qt@5"].opt_prefix}/lib/cmake/Qt5Xml
      -DQt5Network_DIR=#{Formula["qt@5"].opt_prefix}/lib/cmake/Qt5Network
    ]

    system "cmake", ".", *args, *kde_cmake_args
  end
end
