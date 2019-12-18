class KdevPython < Formula
  desc "KDevelop plugin which provides Python language support"
  homepage "https://kde.org/applications/development/org.kde.kdev-python"
  url "https://download.kde.org/stable/kdevelop/5.4.5/src/kdev-python-5.4.5.tar.xz"
  sha256 "a8469886df9a81f3f16db31474a9ed440b1a60224eb28505b5ac63479ad45812"
  head "git://anongit.kde.org/kdev-python.git"

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
