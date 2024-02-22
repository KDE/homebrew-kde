require_relative "../lib/cmake"

class Phonon < Formula
  desc "Multimedia framework for KF5"
  homepage "https://userbase.kde.org/Phonon"
  url "https://download.kde.org/stable/phonon/4.12.0/phonon-4.12.0.tar.xz"
  sha256 "3287ffe0fbcc2d4aa1363f9e15747302d0b080090fe76e5f211d809ecb43f39a"
  head "https://invent.kde.org/libraries/phonon.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build
  depends_on "glib"
  depends_on "qt@5"

  conflicts_with "pulseaudio", because: "fatal error: 'pulse/glib-mainloop.h' file not found"

  def install
    args = %w[
      -DCMAKE_SKIP_RPATH=ON
      -DPHONON_BUILD_PHONON4QT5=ON
      -DPHONON_BUILD_DOC=ON
    ]

    system "cmake", *args, *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Phonon4Qt5 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
