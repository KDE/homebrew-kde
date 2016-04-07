require "formula"

class Kf5Kmymoney < Formula
  homepage "http://kmymoney.org/"
  head "git://anongit.kde.org/kmymoney.git", :branch => "frameworks"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  depends_on "haraldf/kf5/kf5-alkimia"
  depends_on "haraldf/kf5/kf5-kdiagram"
  depends_on "haraldf/kf5/kf5-kcmutils"
  depends_on "haraldf/kf5/kf5-khtml"
  depends_on "haraldf/kf5/kf5-kdelibs4support"

  def patches
    DATA
  end

  def install
    args = std_cmake_args

    args << "-DCMAKE_INSTALL_BUNDLEDIR=/Applications/KDE"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
