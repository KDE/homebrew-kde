require "formula"

class Kf5Dolphin < Formula
  desc "KDE File Manager"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/dolphin.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kactivities"
  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kbookmarks"
  depends_on "haraldf/kf5/kf5-kcmutils"
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-kdoctools"
  depends_on "haraldf/kf5/kf5-kinit"
  depends_on "haraldf/kf5/kf5-kio"
  depends_on "haraldf/kf5/kf5-knewstuff"
  depends_on "haraldf/kf5/kf5-kdelibs4support"
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "haraldf/kf5/kf5-kdesu"
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{prefix}/bin"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      mkdir -p "~/Applications/KDE"
      ln -sf "#{prefix}/bin/dolphin.app" "~/Applications/KDE/"
    EOS
  end

end
