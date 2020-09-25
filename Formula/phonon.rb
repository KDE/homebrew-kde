class Phonon < Formula
  desc "Multimedia framework for KF5"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/phonon/4.11.1/phonon-4.11.1.tar.xz"
  sha256 "b4431ea2600df8137a717741ad9ebc7f7ec1649fa3e138541d8f42597144de2d"
  head "https://invent.kde.org/libraries/phonon.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build
  depends_on "glib"
  depends_on "qt"

  conflicts_with "pulseaudio", because: "fatal error: 'pulse/glib-mainloop.h' file not found"

  def install
    args = std_cmake_args
    args << "-DCMAKE_SKIP_RPATH=ON"
    args << "-DPHONON_BUILD_PHONON4QT5=ON"
    args << "-DPHONON_BUILD_DOC=ON"
    args << "-DCMAKE_INSTALL_DOCDIR=share/doc"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"

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
