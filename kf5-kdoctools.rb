require "formula"

class Kf5Kdoctools < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kdoctools-5.40.0.tar.xz"
  sha256 "3556ffad511980ad84276c8856e7023372e87a65ef8c35db617837ed27b6efff"
  desc "Documentation generation from docbook"
  homepage "http://www.kde.org/"

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
      ln -sf "#{HOMEBREW_PREFIX}/share/kf5" "$HOME/Library/Application Support/"
    EOS
  end
end
