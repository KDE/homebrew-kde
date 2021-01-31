require_relative "../lib/cmake"

class Kf5BreezeIcons < Formula
  desc "Breeze icon themes"
  homepage "https://api.kde.org/frameworks/breeze-icons/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.79/breeze-icons-5.79.0.tar.xz"
  sha256 "c6320406a8e93df3a5918e24ef94b76b3c0ddd3e17567451b7dce403f33b4d1b"
  head "https://invent.kde.org/frameworks/breeze-icons.git"

  depends_on "cmake" => [:build, :test]
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "qt"

  def install
    args = kde_cmake_args
    args << "-DBINARY_ICONS_RESOURCE=TRUE"
    args << "-DSKIP_INSTALL_ICONS=TRUE"

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert_predicate share/"icons/breeze/index.theme", :exist?
    assert_predicate share/"icons/breeze-dark/index.theme", :exist?
  end
end
