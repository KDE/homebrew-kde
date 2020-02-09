class Kf5ExtraCmakeModules < Formula
  desc "Extra modules and scripts for CMake"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.67/extra-cmake-modules-5.67.0.tar.xz"
  sha256 "e803f8740819a5620095c161883c26aaf1267d6f919d547fdd6414e7cccc0150"

  head "git://anongit.kde.org/extra-cmake-modules"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "qt" => :build

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_HTML_DOCS=OFF"
    args << "-DBUILD_QTHELP_DOCS=ON"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(ECM REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
