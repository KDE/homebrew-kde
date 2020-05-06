class KdevPython < Formula
  desc "KDevelop plugin which provides Python language support"
  homepage "https://kde.org/applications/development/org.kde.kdev-python"
  url "https://download.kde.org/stable/kdevelop/5.5.1/src/kdev-python-5.5.1.tar.xz"
  sha256 "9828109d14546bb85fa0ef868919dfe07f6d9e377e4710be6f215ed3343e5bfa"
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
