require "formula"

class Kf5Kactivities < Formula
  desc "Core components for the KDE's Activities"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kactivities-5.39.0.tar.xz"
  sha256 "986a0d40de1ae857639c8b2717a4cfc37288c0b7152bb3225b7e7b63cf0d6c5a"

  head "git://anongit.kde.org/kactivities.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kdeclarative"
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kcmutils"
  depends_on "boost"
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
      ln -sf "#{prefix}/bin/kactivities-cli.app" "~/Applications/KDE/"
    EOS
  end
end
