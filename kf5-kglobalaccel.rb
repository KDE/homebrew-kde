require "formula"

class Kf5Kglobalaccel < Formula
  desc "Add support for global workspace shortcuts"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kglobalaccel-5.39.0.tar.xz"
  sha256 "21ab590c0288193d914ebbbb1be1f8efd5f3a6f8ac0a9592439da1141db78b71"

  head "git://anongit.kde.org/kglobalaccel.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kcrash"
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kservice"
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
