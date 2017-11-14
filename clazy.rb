class Clazy < Formula
  desc "Qt oriented code checker based on clang framework"
  homepage "https://github.com/KDE/clazy"
  url "https://download.kde.org/stable/clazy/1.2/src/clazy-1.2.tar.xz"
  sha256 "c68fed3d719c23ffefeedd88a02984bf37dba6a55dad6359786909a9e5778f91"

  head "git://anongit.kde.org/clazy"

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
