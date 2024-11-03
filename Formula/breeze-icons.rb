require_relative "../lib/cmake"

class BreezeIcons < Formula
  desc "Breeze icon themes"
  homepage "https://api.kde.org/frameworks/breeze-icons/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/breeze-icons-6.7.0.tar.xz"
  sha256 "39037e3fcbbb7a65011685c498cae31ff496a5f2493269c955bb29c94a688b74"
  head "https://invent.kde.org/frameworks/breeze-icons.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "qt@6"

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
