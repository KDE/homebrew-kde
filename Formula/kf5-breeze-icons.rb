require_relative "../lib/cmake"

class Kf5BreezeIcons < Formula
  desc "Breeze icon themes"
  homepage "https://api.kde.org/frameworks/breeze-icons/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.96/breeze-icons-5.96.0.tar.xz"
  sha256 "43a02e6111c87686e24ba570078f31e77af105a5e2eea490f6d375e3f11047c6"
  head "https://invent.kde.org/frameworks/breeze-icons.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "qt@5"

  def install
    args = %w[
      -DBINARY_ICONS_RESOURCE=TRUE
      -DSKIP_INSTALL_ICONS=TRUE
    ]

    system "cmake", *args, *kde_cmake_args
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
