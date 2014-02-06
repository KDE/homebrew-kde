require "formula"

class Ktextwidgets < Formula

  head 'git://anongit.kde.org/ktextwidgets.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/extra-cmake-modules" => :build
  depends_on "haraldf/kf5/ksonnet"
  depends_on "haraldf/kf5/kjs"
  depends_on "haraldf/kf5/kcompletion"
  depends_on "haraldf/kf5/kconfig"
  depends_on "haraldf/kf5/kcoreaddons"
  depends_on "haraldf/kf5/kauth"
  depends_on "haraldf/kf5/kcodecs"
  depends_on "haraldf/kf5/kguiaddons"
  depends_on "haraldf/kf5/kconfigwidgets"
  depends_on "haraldf/kf5/ki18n"
  depends_on "haraldf/kf5/kitemviews"
  depends_on "haraldf/kf5/kiconthemes"
  depends_on "haraldf/kf5/kdbusaddons"
  depends_on "haraldf/kf5/kservice"
  depends_on "haraldf/kf5/kwidgetsaddons"
  depends_on "haraldf/kf5/kwindowsystem"
  depends_on "qt5"

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('extra-cmake-modules').opt_prefix}\""

    system "cmake", ".", *args
    system "make", "install"
  end
end
