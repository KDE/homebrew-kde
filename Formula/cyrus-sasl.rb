class CyrusSasl < Formula
  desc "Cyrus saslauthd SASL authentication daemon"
  homepage "https://www.cyrusimap.org"
  url "https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.27/cyrus-sasl-2.1.27.tar.gz"
  sha256 "26866b1549b00ffd020f188a43c258017fa1c382b3ddadd8201536f72efb05d5"

  head do
    url "https://github.com/cyrusimap/cyrus-sasl.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  keg_only :provided_by_macos

  depends_on "krb5" => :build
  depends_on "openldap" => :build
  depends_on "openssl" => :build
  depends_on "postgresql" => :build
  depends_on "libtool"

  def install
    ENV["NOCONFIGURE"] = "yes"
    system "./autogen.sh" if build.head?
    system "./configure",
           "CFLAGS=-I#{Formula["openssl"].opt_include}",
           "LDFLAGS=-L#{Formula["openssl"].opt_lib}",
           "--disable-macos-framework",
           "--prefix=#{prefix}"
    system "ninja"
    system "ninja", "install"
  end
end
