require "formula"

class Kf5Kio < Formula
  desc "Resource and network access abstraction"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kio-5.39.0.tar.xz"
  sha256 "96cbea5aba34b4e1b0df5ecfb4aaf65ff324341fb00f99796146536557232f24"

  head "git://anongit.kde.org/kio.git"

  option "without-kiowidgets", "Builds only KIO core"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kbookmarks" unless build.without? "kiowidgets"
  depends_on "haraldf/kf5/kf5-kjobwidgets" unless build.without? "kiowidgets"
  depends_on "haraldf/kf5/kf5-kwallet" unless build.without? "kiowidgets"
  depends_on "haraldf/kf5/kf5-solid"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DKIOCORE_ONLY=ON" if build.without? "kiowidgets"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
