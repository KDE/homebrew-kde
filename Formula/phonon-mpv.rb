class PhononMpv < Formula
  desc "Phonon Backend using MPV Player"
  homepage "https://github.com/OpenProgger/phonon-mpv/"
  url "https://github.com/OpenProgger/phonon-mpv/archive/v0.0.5.tar.gz"
  sha256 "6e0e0e3ce8f979106bb4ae277a433cd3d20acba691d8c635ad0d2f1c992d2a32"

  head "https://github.com/OpenProgger/phonon-mpv.git"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/phonon"
  depends_on "mpv"

  def install
    inreplace "#{buildpath}/src/CMakeLists.txt" do |s|
      s.gsub! "phonon_mpv Qt5Gui",
              "phonon_mpv Qt5::Gui"
      s.gsub! "phonon_mpv Qt5X11Extras",
              "phonon_mpv Qt5::X11Extras"
    end

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
