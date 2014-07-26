require "formula"

class Kf5ExtraCmakeModules < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.0.0/extra-cmake-modules-1.0.0.tar.xz"
  sha1 "ddd8ffa7437d2be9b424878fcaeb1dfe7e799c7c"

  keg_only "Only required for building KDE frameworks"

  head 'git://anongit.kde.org/extra-cmake-modules'

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    prefix.install "install_manifest.txt"

    ### Hack - QStandardDirs only looks in $HOME/Library/Application Support/, but kf5 installs
    ### to share. Make a symlink
    ln_sf Dir["#{HOMEBREW_PREFIX}/share/kf5"], "#{ENV['HOME']}/Library/Application Support/"
  end
end
