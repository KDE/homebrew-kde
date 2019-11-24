class KdevPhp < Formula
  desc "PHP Language Plugin for KDevelop/Quanta"
  homepage "https://kde.org/applications/development/org.kde.kdev-php"
  url "https://download.kde.org/stable/kdevelop/5.4.4/src/kdev-php-5.4.4.tar.xz"
  sha256 "6047265553018f30c6f55ecfa3b095d8bf5c629223b078e0968c75710f1f670e"
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
