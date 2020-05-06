class KdevPhp < Formula
  desc "PHP Language Plugin for KDevelop/Quanta"
  homepage "https://kde.org/applications/development/org.kde.kdev-php"
  url "https://download.kde.org/stable/kdevelop/5.5.1/src/kdev-php-5.5.1.tar.xz"
  sha256 "907398753fdd30361b922252f0cde76cfe336692f7180f612e1706085bce7542"
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
