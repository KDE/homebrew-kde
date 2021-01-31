require_relative "../lib/cmake"

class Clazy < Formula
  desc "Qt oriented code checker based on clang framework"
  homepage "https://github.com/KDE/clazy"
  url "https://download.kde.org/stable/clazy/1.9/src/clazy-1.9.tar.xz"
  sha256 "4c6c2e473e6aa011cc5fab120ebcffec3fc11a9cc677e21ad8c3ea676eb076f8"
  revision 1
  head "https://invent.kde.org/sdk/clazy.git"

  depends_on "cmake" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "llvm"
  depends_on "qt"

  def install
    args = kde_cmake_args
    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    assert_match "help", shell_output("#{bin}/clazy-standalone --help")
  end
end
