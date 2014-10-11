require "formula"

class Kf5ExtraCmakeModules < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.3.0/extra-cmake-modules-1.3.0.tar.xz"
  sha1 "d84f8fe0edfcd79938992ce1b23ca7870533a991"

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
    ln_sf Dir["#{HOMEBREW_PREFIX}/share/kxmlgui5"], "#{ENV['HOME']}/Library/Application Support/"
  end
end
