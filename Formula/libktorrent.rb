class Libktorrent < Formula
  desc "BitTorrent protocol implementation"
  homepage "https://www.kde.org/applications/internet/ktorrent/"
  url "https://download.kde.org/stable/ktorrent/5.1/libktorrent-2.1.tar.xz"
  sha256 "3eefdcceec73410c558e82d7be22eb2ed18679e9ab64f34cc100b54e186fe26f"

  head "git://anongit.kde.org/libktorrent.git"
  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kio"
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
    (testpath/"CMakeLists.txt").write("find_package(LibKWorkspace)")
    system bin/"cmake", "."
  end
end
