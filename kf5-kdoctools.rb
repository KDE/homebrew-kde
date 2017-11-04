require "formula"

class Kf5Kdoctools < Formula
  desc "Documentation generation from docbook"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kdoctools-5.39.0.tar.xz"
  sha256 "57a12705b87754d8bbc76e3400691d02072d61bd0e2e4b62845dca558f9be49d"

  head "git://anongit.kde.org/kdoctools.git"

  depends_on "cmake" => :build
  depends_on "perl" => :build
  depends_on "cpanminus" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-karchive"
  depends_on "qt"
  depends_on "docbook"
  depends_on "docbook-xsl"
  depends_on "gettext"

  def install
    args = std_cmake_args
    args << "-DDocBookXML_CURRENTDTD_DIR:PATH=#{Formulary.factory("docbook").prefix}/docbook/xml/4.2"
    args << "-DDocBookXSL_DIR:PATH=#{Formulary.factory("docbook-xsl").prefix}/docbook-xsl"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    Before install of this formula you need to run:
      cpanm URI

    You need to take some manual steps in order to make this formula work:
      ln -sf "#{share}/kf5" "$HOME/Library/Application Support/"
    EOS
  end
end
