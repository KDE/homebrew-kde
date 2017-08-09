# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Clazy < Formula
  desc "Qt oriented code checker based on clang framework. Krazy's little brother."
  homepage ""
  url "https://github.com/KDE/clazy/archive/v1.2.tar.gz"
  sha256 "e4177a1a0e1d03577714fd95091e2af2f9ec0bda6cab1d1eab4f3232f53afb7e"

  depends_on "cmake" => :build
  depends_on "llvm"
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
 end 
end
