require "formula"

class Kf5ExtraCmakeModules < Formula
  url "http://download.kde.org/stable/frameworks/5.25/extra-cmake-modules-5.25.0.tar.xz"
  sha256 "73c90e67c328076c2bee35884836087e7e9f753e48fc0063c8348b6f66b0345f"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/extra-cmake-modules'

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    prefix.install "install_manifest.txt"

    ### Hack - QStandardDirs only looks in $HOME/Library/Application Support/, but kf5 installs
    ### to share. Make a symlink
    ln_sf Dir["#{HOMEBREW_PREFIX}/share/kf5"], "#{ENV['HOME']}/Library/Application Support/"
    ln_sf Dir["#{HOMEBREW_PREFIX}/share/kxmlgui5"], "#{ENV['HOME']}/Library/Application Support/"
  end
end
