class KdevPython < Formula
  desc "KDevelop plugin which provides Python language support"
  homepage "https://kde.org/applications/development/org.kde.kdev-python"
  url "https://download.kde.org/stable/kdevelop/5.5.2/src/kdev-python-5.5.2.tar.xz"
  sha256 "2e70249e48eb1c5720a3304761454b0d203bfec9473121dd0d25b977a91f7edc"
  head "https://invent.kde.org/kdevelop/kdev-python.git"

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
