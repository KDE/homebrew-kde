require "formula"

class Kf5Ktexteditor < Formula
  desc "Advanced embeddable text editor"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/ktexteditor-5.39.0.tar.xz"
  sha256 "c5d9c67532ab6f3abee8ae2623ff21e6ca5280d5ea9ca5d23bdb55f937e565ae"

  head "git://anongit.kde.org/ktexteditor.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "haraldf/kf5/kf5-syntax-highlighting"
  depends_on "qt"

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
      ln -sf "#{HOMEBREW_PREFIX}/share/kservicetypes5" "~/Library/Application Support/"
    EOS
  end
end
