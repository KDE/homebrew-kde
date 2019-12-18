class KdevPhp < Formula
  desc "PHP Language Plugin for KDevelop/Quanta"
  homepage "https://kde.org/applications/development/org.kde.kdev-php"
  url "https://download.kde.org/stable/kdevelop/5.4.5/src/kdev-php-5.4.5.tar.xz"
  sha256 "f8126131f521b2497fa62ad79ba276a68a45e40b48406c6686658708780ade32"
  head "git://anongit.kde.org/kdev-php.git"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "kdevelop"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
