require_relative "../lib/cmake"

class PhononMpv < Formula
  desc "Phonon Backend using MPV Player"
  homepage "https://github.com/OpenProgger/phonon-mpv/"
  url "https://github.com/OpenProgger/phonon-mpv/archive/v0.0.7.tar.gz"
  sha256 "c674e982d81dcdb2cfca3244e55a4c1e5b35cfc4bed3c7bd65921358d8a0ebc6"
  revision 1
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
    assert_predicate lib/"plugins/phonon4qt5_backend/phonon_mpv.so", :exist?
  end
end
