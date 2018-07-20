class Libcerf < Formula
  desc "Efficient implementation of complex error functions"
  homepage "http://apps.jcns.fz-juelich.de/doku/sc/libcerf"
  url "http://apps.jcns.fz-juelich.de/src/libcerf/libcerf-1.5.tgz"
  sha256 "e36dc147e7fff81143074a21550c259b5aac1b99fc314fc0ae33294231ca5c86"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <cerf.h>
      #include <stdio.h>
      int main()
      {
        printf("%f\\n", voigt(0, 1, 0));
        return -1;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lcerf", "-o", "test"
    assert_in_delta `./test`.to_f, 1 / Math.sqrt(2 * Math::PI), 1e-6
  end
end
