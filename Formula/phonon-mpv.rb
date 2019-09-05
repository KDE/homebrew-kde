class PhononMpv < Formula
  desc "Phonon Backend using MPV Player"
  homepage "https://github.com/OpenProgger/phonon-mpv/"
  url "https://github.com/OpenProgger/phonon-mpv/archive/v0.0.7.tar.gz"
  sha256 "c674e982d81dcdb2cfca3244e55a4c1e5b35cfc4bed3c7bd65921358d8a0ebc6"

  head "https://github.com/OpenProgger/phonon-mpv.git"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/phonon"
  depends_on "mpv"

  def install
    args = std_cmake_args
    args << "-DCMAKE_CXX_STANDARD=17"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    assert_predicate lib/"plugins/phonon4qt5_backend/phonon_mpv.so", :exist?
  end
end
