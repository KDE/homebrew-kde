class Clazy < Formula
  desc "Qt oriented code checker based on clang framework"
  homepage "https://github.com/KDE/clazy"
  url "https://download.kde.org/stable/clazy/1.4/src/clazy-1.4.tar.xz"
  sha256 "3f5d5e148c9e9c4e43f095796261794da5385578d2375b12c9179d340d6d5a8a"

  head "git://anongit.kde.org/clazy.git"

  depends_on "cmake" => :build

  depends_on "llvm"
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DCMAKE_INSTALL_MANDIR=#{man}"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
