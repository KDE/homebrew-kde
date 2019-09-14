class KdevPhp < Formula
  desc "PHP Language Plugin for KDevelop/Quanta"
  homepage "https://kde.org/applications/development/org.kde.kdev-php"
  url "https://download.kde.org/stable/kdevelop/5.4.2/src/kdev-php-5.4.2.tar.xz"
  sha256 "360444b7ac7c2f35144b4e13054a169b705b44e66219bd988ec1137e07994967"
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
