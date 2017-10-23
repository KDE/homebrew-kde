require "formula"

class Kf5Kdesu < Formula
  desc "Integration with su for elevated privileges"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kdesu-5.39.0.tar.xz"
  sha256 "9d9b1d202ad09993dd6c0bfe3bf4738e1867dc563bcd49b664e3026534fc5b0d"

  head "git://anongit.kde.org/kdesu.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kpty"
  depends_on "qt"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
