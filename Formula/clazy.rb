class Clazy < Formula
  desc "Qt oriented code checker based on clang framework"
  homepage "https://github.com/KDE/clazy"
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
