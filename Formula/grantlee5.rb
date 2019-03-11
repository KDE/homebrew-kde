class Grantlee5 < Formula
  desc "String template engine based on the Django template system"
  homepage "http://grantlee.org"
  url "https://github.com/steveire/grantlee/archive/v5.1.0.tar.gz"
  sha256 "3836572fe5e49d28a1d99186c6d96f88ff839644b4bc77b73b6d8208f6ccc9d1"
  revision 2

  head "https://github.com/steveire/grantlee.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "lcov" => :build
  depends_on "ninja" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTS=OFF"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
