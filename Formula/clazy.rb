class Clazy < Formula
  desc "Qt oriented code checker based on clang framework"
  homepage "https://github.com/KDE/clazy"
  url "https://download.kde.org/stable/clazy/1.6/src/clazy-1.6.tar.xz"
  sha256 "806d1befaddba82316f4ea34f1cba38bcc7545d0981007e3527c1ff1576dd0de"
  head "git://anongit.kde.org/clazy.git"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  depends_on "llvm"
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DCMAKE_INSTALL_MANDIR=#{man}"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    assert `"#{bin}/clazy-standalone" --help | grep -- -help` =~ /-help/
  end
end
