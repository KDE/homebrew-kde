require "formula"

class Kf5ExtraCmakeModules < Formula
  url "http://download.kde.org/stable/frameworks/5.40/extra-cmake-modules-5.40.0.tar.xz"
  sha256 "83e48889c84474e4f560e10e4eea0cc529f8511b3bd0415fcb898ac0496e630a"
  desc "Extra modules and scripts for CMake"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/extra-cmake-modules"

  depends_on "cmake" => :build

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "#{HOMEBREW_PREFIX}/share/kf5" "$HOME/Library/Application Support/"
      ln -sf "#{HOMEBREW_PREFIX}/share/kxmlgui5" "$HOME/Library/Application Support/"
    EOS
  end
end
