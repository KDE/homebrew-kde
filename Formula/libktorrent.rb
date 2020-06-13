class Libktorrent < Formula
  desc "BitTorrent protocol implementation"
  homepage "https://www.kde.org/applications/internet/ktorrent/"
  url "https://download.kde.org/stable/ktorrent/5.2.0/libktorrent-2.2.0.tar.xz"
  sha256 "77c1ddfb0a56c40227e0624c078836a8c22bf5a2fb4a3c0cbd53ee6b174c126e"
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
