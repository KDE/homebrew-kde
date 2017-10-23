require "formula"

class Kf5Kxmlgui < Formula
  desc "User configurable main windows"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kxmlgui-5.39.0.tar.xz"
  sha256 "2584cf5b39414b4bf76817d5f09dcdf5cd2e1554ac424386a0f0fa0173089e7f"

  head "git://anongit.kde.org/kxmlgui.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kglobalaccel"
  depends_on "haraldf/kf5/kf5-ktextwidgets"
  depends_on "haraldf/kf5/kf5-attica"
  depends_on "qt"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
