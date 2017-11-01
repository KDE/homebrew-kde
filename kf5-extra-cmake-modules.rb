require "formula"

class Kf5ExtraCmakeModules < Formula
  desc "Extra modules and scripts for CMake"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/extra-cmake-modules-5.39.0.tar.xz"
  sha256 "b80536d7bed8c12fc492857d3d433b3859462402fe231e463efcd3bf44ffbcd1"

  head "git://anongit.kde.org/extra-cmake-modules"

  depends_on "cmake" => :build
  depends_on "qt" => :build

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kf5" ~/Library/"Application Support"
      ln -sf "$(brew --prefix)/share/kxmlgui5" ~/Library/"Application Support"
    EOS
  end
end
