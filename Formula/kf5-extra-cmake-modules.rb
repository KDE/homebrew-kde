class Kf5ExtraCmakeModules < Formula
  desc "Extra modules and scripts for CMake"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.66/extra-cmake-modules-5.66.0.tar.xz"
  sha256 "2ff1a4ede28488ea787e742ab37edaacc5f59bf9188476e48f681ce23300b9c4"

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
