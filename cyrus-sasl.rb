require "formula"

class CyrusSasl < Formula
  homepage "https://www.cyrusimap.org/"
  url "ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-2.1.26.tar.gz"
  sha256 "8fbc5136512b59bb793657f36fadda6359cae3b08f01fd16b3d406f1345b7bc3"

  keg_only :provided_by_osx

  depends_on "openssl"

  def install
    system "./configure",
           "CFLAGS=-I#{HOMEBREW_PREFIX}/opt/openssl/include ",
           "LDFLAGS=-L#{HOMEBREW_PREFIX}/opt/openssl/lib",
           "--disable-macos-framework",
           "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
