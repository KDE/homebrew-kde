class Kf5BreezeIcons < Formula
  desc "Breeze icon themes"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.77/breeze-icons-5.77.0.tar.xz"
  sha256 "96ad021edd6999e632991bff286f13601b898dc623388e52e82b68b5ac0a0f82"
  head "https://invent.kde.org/frameworks/breeze-icons.git"

  depends_on "cmake" => [:build, :test]
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DKDE_INSTALL_QTPLUGINDIR=lib/qt5/plugins"
    args << "-DBINARY_ICONS_RESOURCE=TRUE"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
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
