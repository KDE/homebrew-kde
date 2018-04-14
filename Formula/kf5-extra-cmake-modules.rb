class Kf5ExtraCmakeModules < Formula
  desc "Extra modules and scripts for CMake"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.45/extra-cmake-modules-5.45.0.tar.xz"
  sha256 "e6d49dcbf37a1887d4e08d1381318bad064ab214ab021030d74ce2657e93f63c"

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
