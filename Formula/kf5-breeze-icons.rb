require_relative "../lib/cmake"

class Kf5BreezeIcons < Formula
  desc "Breeze icon themes"
  homepage "https://api.kde.org/frameworks/breeze-icons/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.84/breeze-icons-5.84.0.tar.xz"
  sha256 "049a26594de966a215ea4546bbf76a2395def31a637eb26820258d7c0962408c"
  head "https://invent.kde.org/frameworks/breeze-icons.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "qt@5"

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
