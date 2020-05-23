class Libktorrent < Formula
  desc "BitTorrent protocol implementation"
  homepage "https://www.kde.org/applications/internet/ktorrent/"
  url "https://download.kde.org/stable/ktorrent/5.1.2/libktorrent-2.1.1.tar.xz"
  sha256 "5cc45c0b50a1b6b2ce64ad0384128f4ac3bc0e4a1417eb58e5e992b510fca100"
  head "git://anongit.kde.org/libktorrent.git"

  depends_on "boost" => :build
  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "qca"
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Torrent REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
