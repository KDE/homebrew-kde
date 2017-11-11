require "formula"

class Kf5Kactivities < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kactivities-5.40.0.tar.xz"
  sha256 "4bfdd61ff15670d9f481f5957f4d30dc1b2723d23baaa3489e6350a37f7dcd30"
  desc "Core components for the KDE's Activities"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kactivities.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kdeclarative"
  depends_on "KDE-mac/kde/kf5-kdbusaddons"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kcmutils"
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
      mkdir -p "$HOME/Applications/KDE"
      ln -sf "#{prefix}/bin/kactivities-cli.app" "$HOME/Applications/KDE"
    EOS
  end
end
