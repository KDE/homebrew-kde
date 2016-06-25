require "formula"

class CyrusSasl < Formula
  homepage "https://www.cyrusimap.org/"
  url "ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-2.1.26.tar.gz"

  depends_on "openssl"
  keg_only :provided_by_osx

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

