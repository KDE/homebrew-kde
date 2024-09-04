require_relative "../lib/cmake"

class Kf6Knewstuff < Formula
  desc "Support for downloading application assets from the network"
  homepage "https://api.kde.org/frameworks/knewstuff/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/knewstuff-6.5.0.tar.xz"
  sha256 "815589a660b9a53a1fc18268b95914636124b6f3f3193c9404e0959f8b738c79"
  head "https://invent.kde.org/frameworks/knewstuff.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "qt@6"
  depends_on "kde-mac/kde/kf6-kio"
  depends_on "kde-mac/kde/kf6-kirigami"
  depends_on "kde-mac/kde/kf6-kpackage"

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
      find_package(KF6NewStuff REQUIRED)
      find_package(KF6NewStuffCore REQUIRED)
      find_package(KF6NewStuffQuick REQUIRED)
    EOS

    args = %W[
      -DQt5Widgets_DIR=#{Formula["qt@6"].opt_prefix}/lib/cmake/Qt6Widgets
      -DQt5Xml_DIR=#{Formula["qt@6"].opt_prefix}/lib/cmake/Qt6Xml
      -DQt5Network_DIR=#{Formula["qt@6"].opt_prefix}/lib/cmake/Qt6Network
    ]

    system "cmake", ".", *args, *kde_cmake_args
  end
end
