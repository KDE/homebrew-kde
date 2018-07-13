class Phonon < Formula
  desc "The multimedia framework for KF5"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/phonon/4.10.1/phonon-4.10.1.tar.xz"
  sha256 "e5a98df31aeffc22493afc8d6adbca5d6f0c27cc2eed73b3be05195321e08db7"

  head "git://anongit.kde.org/phonon.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DCMAKE_SKIP_RPATH=ON"
    args << "-DPHONON_BUILD_PHONON4QT5=ON"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
