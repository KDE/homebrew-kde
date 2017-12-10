class Kf5ExtraCmakeModules < Formula
  desc "Extra modules and scripts for CMake"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.41/extra-cmake-modules-5.41.0.tar.xz"
  sha256 "baaf60940b9ff883332629ba2800090bb86722ba49a85cc12782e4ee5b169f67"
  revision 1

  head "git://anongit.kde.org/extra-cmake-modules"

  depends_on "cmake" => :build
  depends_on "qt" => :build

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_HTML_DOCS=OFF"
    args << "-DBUILD_QTHELP_DOCS=ON"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
