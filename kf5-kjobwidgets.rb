require "formula"

class Kf5Kjobwidgets < Formula
  desc "Widgets for tracking KJob instances"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kjobwidgets-5.39.0.tar.xz"
  sha256 "ccfd26c54e15a854d4d86028e7339dcbe33b0c52412686b89b2dc7794b2946fc"

  head "git://anongit.kde.org/kjobwidgets.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons"
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
