require "formula"

class Kf5Kdoctools < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/kdoctools-5.34.0.tar.xz"
  sha256 "50000a2e43bae1dd49f37c4160b8569c482fc3125fae1f92641572d03494b290"

  head "git://anongit.kde.org/kdoctools.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "qt5"
  depends_on "docbook"
  depends_on "docbook-xsl"
  depends_on "gettext"

  def patches
    DATA
  end

  def install
    args = std_cmake_args

    args << "-DDocBookXML_CURRENTDTD_DIR:PATH=#{Formulary.factory("docbook").prefix}/docbook/xml/4.2"
    args << "-DDocBookXSL_DIR:PATH=#{Formulary.factory("docbook-xsl").prefix}/docbook-xsl"

    system "cmake", ".", *args
    system "make", "install"
    ln_s Dir["#{share}/kf5"], "#{Etc.getpwuid.dir}/Library/Application Support/", :force => true
    prefix.install "install_manifest.txt"
  end

  def caveats; <<-EOS.undent
    A symlink "#{ENV["HOME"]}/Library/Application Support/kf5" was created
    So that "kf5/kdoctools/customization" can be found when building other kf5 modules.

    This symlink can be removed when this formula is uninstalled.
    EOS
  end
end
