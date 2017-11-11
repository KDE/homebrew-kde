require "formula"

class Kf5Kross < Formula
  url "http://download.kde.org/stable/frameworks/5.40/portingAids/kross-5.40.0.tar.xz"
  sha256 "17a570e2e742e06dc6b28e8610fc1795312be960938ce25acf480005f5d409f9"
  desc "Multi-language application scripting"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kross.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{prefix}/bin"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      mkdir -p "$HOME/Applications/KDE"
      ln -sf "#{prefix}/bin/kf5kross.app" "$HOME/Applications/KDE"
    EOS
  end
end
