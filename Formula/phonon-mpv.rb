class PhononMpv < Formula
  desc "Phonon Backend using MPV Player"
  homepage "https://github.com/OpenProgger/phonon-mpv/"
  url "https://github.com/OpenProgger/phonon-mpv/archive/v0.0.6.tar.gz"
  sha256 "f6e649751384f6066c91c685db2b2e82db79178a994a7bb56d0f5ed2fa7d4649"

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
    assert_predicate lib/"qt5/plugins/phonon4qt5_backend/phonon_mpv.so", :exist?
  end
end
