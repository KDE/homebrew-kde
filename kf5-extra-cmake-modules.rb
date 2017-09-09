require "formula"

class Kf5ExtraCmakeModules < Formula
  url "http://download.kde.org/stable/frameworks/5.38/extra-cmake-modules-5.38.0.tar.xz"
  sha256 "6188a8ac8d799439204f69a1eb229431fc9f196790b88d6fb72bb3d57edb2332"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/extra-cmake-modules"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    prefix.install "install_manifest.txt"

    ### Hack - QStandardDirs only looks in $HOME/Library/Application Support/, but kf5 installs
    ### to share. Make a symlink
    # ln_sf Dir["#{HOMEBREW_PREFIX}/share/kf5"], "#{Etc.getpwuid.dir}/Library/Application Support/"
    # ln_sf Dir["#{HOMEBREW_PREFIX}/share/kxmlgui5"], "#{Etc.getpwuid.dir}/Library/Application Support/"
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "#{HOMEBREW_PREFIX}/share/kf5" "~/Library/Application Support/"
      ln -sf "#{HOMEBREW_PREFIX}/share/kxmlgui5" "~/Library/Application Support/"
    EOS
  end
end
