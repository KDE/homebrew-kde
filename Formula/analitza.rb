class Analitza < Formula
  desc "Library to add mathematical features to your program"
  homepage "https://edu.kde.org/"
  url "https://download.kde.org/stable/release-service/19.12.2/src/analitza-19.12.2.tar.xz"
  sha256 "b64025efd028f1968a3081970d3195d5a3378bc4550b92ef93c149bc2a5bbfe1"

  head "git://anongit.kde.org/analitza.git"

  depends_on "cmake" => :build
  depends_on "eigen" => :build
  depends_on "kf5-extra-cmake-modules" => :build
  depends_on "kf5-kdoctools" => :build
  depends_on "ninja" => :build

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    args << "-DCMAKE_INSTALL_LIBDIR=#{lib}"
    args << "-DBUILD_TESTING=OFF"
    args << "-DCMAKE_PREFIX_PATH=" + Formula["qt"].opt_prefix + "/lib/cmake"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Analitza5 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
