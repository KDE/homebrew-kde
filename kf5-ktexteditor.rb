require "formula"

class Kf5Ktexteditor < Formula
  url "http://download.kde.org/stable/frameworks/5.38/ktexteditor-5.38.0.tar.xz"
  sha256 "31e7b3118a2cb56176d85538ef43f41842add3ef5c881786a7db7122c37ebea4"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/ktexteditor.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "haraldf/kf5/kf5-syntax-highlighting"

  def install
    # ln_sf Dir["#{HOMEBREW_PREFIX}/share/kservicetypes5"], "#{Etc.getpwuid.dir}/Library/Application Support/"
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "#{HOMEBREW_PREFIX}/share/kservicetypes5" "~/Library/Application Support/"
    EOS
  end
end
