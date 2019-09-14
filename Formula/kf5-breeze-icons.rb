class Kf5BreezeIcons < Formula
  desc "Breeze icon themes"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.62/breeze-icons-5.62.0.tar.xz"
  sha256 "5858100f1a87dc865f44cde159aaee025ec46f894f544c75086ea0e8f9555951"

  head "git://anongit.kde.org/breeze-icons.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
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

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
  EOS
  end

  test do
    assert_predicate share/"icons/breeze/index.theme", :exist?
    assert_predicate share/"icons/breeze-dark/index.theme", :exist?
  end
end
