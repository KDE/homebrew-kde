require "formula"

class Kf5Threadweaver < Formula
  desc "High-level multithreading framework"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/threadweaver-5.39.0.tar.xz"
  sha256 "5c116d93f2ca7bdc75db8d59a4b4852d2c7db48073ad3de21e4bfbf6339a2b80"

  head "git://anongit.kde.org/threadweaver.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
