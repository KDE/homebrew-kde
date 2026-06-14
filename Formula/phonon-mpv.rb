require_relative "../lib/cmake"

class PhononMpv < Formula
  desc "Phonon Backend using MPV Player"
  homepage "https://github.com/OpenProgger/phonon-mpv/"
  url "https://github.com/OpenProgger/phonon-mpv/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "8cba7d803c23267bf7431bf79c4a65a03c767c01026a0cced18985bfa418a076"
  head "https://github.com/OpenProgger/phonon-mpv.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/phonon"
  depends_on "mpv"

  def install
    system "cmake", "-DCMAKE_CXX_STANDARD=17", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    assert_path_exists lib/"plugins/phonon4qt5_backend/phonon_mpv.so"
  end
end
