require "formula"

class Kf5Kcompletion < Formula
  desc "Text completion helpers and widgets"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kcompletion-5.39.0.tar.xz"
  sha256 "ba1e6a72e827d2657d518111271cf12eeddb70ec68b0f8943d4bfa632f614d26"

  head "git://anongit.kde.org/kcompletion.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
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
