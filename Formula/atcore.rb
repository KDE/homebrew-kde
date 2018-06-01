class Atcore < Formula
  desc "API to manage the connection to 3D Printers"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/atcore/1.0.0/atcore-1.0.0.tar.xz"
  sha256 "ffd12455c9b8db853e455a437d6c6b601e0003c6732bbc6c2828032e004530e2"

  head "git://anongit.kde.org/atcore.git"

  option "with-gui", "Build atcore-gui (HEAD ONLY)"

  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "cmake" => :build
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    if build.with?("gui")
      args << "-DBUILD_GUI=ON"
    end

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
