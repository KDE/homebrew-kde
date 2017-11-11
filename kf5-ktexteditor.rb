require "formula"

class Kf5Ktexteditor < Formula
  url "http://download.kde.org/stable/frameworks/5.40/ktexteditor-5.40.0.tar.xz"
  sha256 "b6d48e3a1fb7dc6c8c6a2bc11743e928dca02d6b1e342261eedbb320f5eb9076"
  desc "Advanced embeddable text editor"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/ktexteditor.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-syntax-highlighting"
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
      ln -sf "#{HOMEBREW_PREFIX}/share/kservicetypes5" "$HOME/Library/Application Support/"
    EOS
  end
end
