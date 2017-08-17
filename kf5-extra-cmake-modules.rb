require "formula"

class Kf5ExtraCmakeModules < Formula
  url "http://download.kde.org/stable/frameworks/5.37/extra-cmake-modules-5.37.0.tar.xz"
  sha256 "26198cf05c084c158bb23f0585a9df5bba1aa16b746252c80bdf4f0261b527cb"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/extra-cmake-modules"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    prefix.install "install_manifest.txt"

    ### Hack - QStandardDirs only looks in $HOME/Library/Application Support/, but kf5 installs
    ### to share. Make a symlink
    ln_sf Dir["#{HOMEBREW_PREFIX}/share/kf5"], "#{Etc.getpwuid.dir}/Library/Application Support/"
    ln_sf Dir["#{HOMEBREW_PREFIX}/share/kxmlgui5"], "#{Etc.getpwuid.dir}/Library/Application Support/"
  end
end
