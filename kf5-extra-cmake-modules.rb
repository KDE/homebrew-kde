require "formula"

class Kf5ExtraCmakeModules < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/extra-cmake-modules-5.34.0.tar.xz"
  sha256 "05da02a2db64d20a7a92be6dc642df39da39f957dea8fba9bcb99fb3f3f66de4"

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
