class Kf5Kapidox < Formula
  desc "Frameworks API Documentation Tools"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.57/kapidox-5.57.0.tar.xz"
  sha256 "16f53e4722adddaa8729b4cccc374d16bdbfdd987f8655d2b431a91b046fe2b2"

  head "git://anongit.kde.org/kapidox.git"
  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build
  depends_on "qt" => :build

  def install
    args = std_cmake_args
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
