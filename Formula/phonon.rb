class Phonon < Formula
  desc "The multimedia framework for KF5"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/phonon/4.10.3/phonon-4.10.3.tar.xz"
  sha256 "2e8b145669afa0e93833e4064b657677abc9413e4007fa5ddc91397c9bddc295"

  head "git://anongit.kde.org/phonon.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build
  depends_on "glib"
  depends_on "qt"

  conflicts_with "pulseaudio", :because => "fatal error: 'pulse/glib-mainloop.h' file not found"

  def install
    inreplace "#{buildpath}/doc/CMakeLists.txt",
              "SHARE_INSTALL_PREFIX}/libphonon/",
              "CMAKE_INSTALL_DOCDIR}/libphonon"

    args = std_cmake_args
    args << "-DCMAKE_SKIP_RPATH=ON"
    args << "-DPHONON_BUILD_PHONON4QT5=ON"
    args << "-DPHONON_BUILD_DOC=ON"
    args << "-DCMAKE_INSTALL_DOCDIR=share/doc"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Phonon4Qt5 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
