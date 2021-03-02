require_relative "../lib/cmake"

class Phonon < Formula
  desc "Multimedia framework for KF5"
  homepage "https://phonon.kde.org/"
  url "https://download.kde.org/stable/phonon/4.11.1/phonon-4.11.1.tar.xz"
  sha256 "b4431ea2600df8137a717741ad9ebc7f7ec1649fa3e138541d8f42597144de2d"
  revision 1
  head "https://invent.kde.org/libraries/phonon.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build
  depends_on "glib"
  depends_on "qt"

  conflicts_with "pulseaudio", because: "fatal error: 'pulse/glib-mainloop.h' file not found"

  def install
    args = kde_cmake_args << "-DCMAKE_SKIP_RPATH=ON"
    args << "-DPHONON_BUILD_PHONON4QT5=ON"
    args << "-DPHONON_BUILD_DOC=ON"

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Phonon4Qt5 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
