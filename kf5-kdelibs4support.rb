require "formula"

class Kf5Kdelibs4support < Formula
  desc "Porting aid from KDELibs4"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/portingAids/kdelibs4support-5.39.0.tar.xz"
  sha256 "d735000260d8565e812b96c81d510acef14f7b66e9fcbbd2d42711bd1bfcb20f"

  head "git://anongit.kde.org/kdelibs4support.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kded"
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-kdesignerplugin"
  depends_on "haraldf/kf5/kf5-kemoticons"
  depends_on "haraldf/kf5/kf5-kinit"
  depends_on "haraldf/kf5/kf5-kitemmodels"
  depends_on "haraldf/kf5/kf5-kunitconversion"
  depends_on "haraldf/kf5/kf5-kparts"
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
