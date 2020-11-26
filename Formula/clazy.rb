class Clazy < Formula
  desc "Qt oriented code checker based on clang framework"
  homepage "https://github.com/KDE/clazy"
  url "https://download.kde.org/stable/clazy/1.8/src/clazy-1.8.tar.xz"
  sha256 "ff0a5b5e694149df5f60bb7a4dc253ee4752b803453c5d29fa79611b54ecffdc"
  head "https://invent.kde.org/sdk/clazy.git"

  depends_on "cmake" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "llvm"
  depends_on "qt"

  def install
    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *std_cmake_args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    assert_match "help", shell_output("#{bin}/clazy-standalone --help")
  end
end
