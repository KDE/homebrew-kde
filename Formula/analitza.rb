class Analitza < Formula
  desc "Library to add mathematical features to your program"
  homepage "https://edu.kde.org/"
  url "https://download.kde.org/stable/applications/18.08.1/src/analitza-18.08.1.tar.xz"
  sha256 "c27d78e1a41be311f9408fc87b06285a0f841570eedfff94bc4b3a41e5cbff87"

  head "git://anongit.kde.org/analitza.git"

  depends_on "cmake" => :build
  depends_on "eigen" => :build
  depends_on "kf5-extra-cmake-modules" => :build
  depends_on "kf5-kdoctools" => :build

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    args << "-DCMAKE_INSTALL_LIBDIR=#{lib}"
    args << "-DBUILD_TESTING=OFF"
    args << "-DCMAKE_PREFIX_PATH=" + Formula["qt"].opt_prefix + "/lib/cmake"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
