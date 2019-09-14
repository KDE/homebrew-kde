class Grantlee < Formula
  desc "String template engine based on the Django template system"
  homepage "http://grantlee.org"
  head "https://github.com/steveire/grantlee.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "lcov" => :build
  depends_on "ninja" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTS=OFF"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Grantlee5 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
