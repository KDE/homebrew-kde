class KdevPhp < Formula
  desc "PHP Language Plugin for KDevelop/Quanta"
  homepage "https://kde.org/applications/development/org.kde.kdev-php"
  url "https://download.kde.org/stable/kdevelop/5.5.2/src/kdev-php-5.5.2.tar.xz"
  sha256 "05b8a2f1bdc86ce03f4c5121c29dadcf32daf52b34bbf54fbcd250494f3bd6a2"
  head "https://invent.kde.org/kdevelop/kdev-php.git"

  depends_on "cmake" => [:build, :test]
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
