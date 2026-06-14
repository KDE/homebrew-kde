require_relative "../lib/cmake"

class Kf5BreezeIcons < Formula
  desc "Breeze icon themes"
  homepage "https://api.kde.org/frameworks/breeze-icons/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.116/breeze-icons-5.116.0.tar.xz"
  sha256 "bd41fad0135606ce0a00a395aaf88cb0a7989f998cfb44cd6e0b777fb75bf3d2"
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
    assert_path_exists share/"icons/breeze/index.theme"
    assert_path_exists share/"icons/breeze-dark/index.theme"
  end
end
