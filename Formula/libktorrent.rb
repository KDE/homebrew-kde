class Libktorrent < Formula
  desc "BitTorrent protocol implementation"
  homepage "https://www.kde.org/applications/internet/ktorrent/"
  url "https://download.kde.org/stable/release-service/20.12.1/src/libktorrent-20.12.1.tar.xz"
  sha256 "bbaa68598993cf83e21d036b53b901efa190ea5e49b394ccc23f3e62c0caaca2"
  head "https://invent.kde.org/network/libktorrent.git"

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
