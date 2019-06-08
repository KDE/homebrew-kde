class Kf5Tier1Frameworks < Formula
  desc "Metapackage for Tier 1 KF5 frameworks"
  homepage "https://api.kde.org/frameworks"
  system "touch", "/tmp/empty"
  url "file:///tmp/empty"
  version "5.59.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on "KDE-mac/kde/kf5-attica" => :build
  depends_on "KDE-mac/kde/kf5-breeze-icons" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kapidox" => :build
  depends_on "KDE-mac/kde/kf5-karchive" => :build
  depends_on "KDE-mac/kde/kf5-kcodecs" => :build
  depends_on "KDE-mac/kde/kf5-kconfig" => :build
  depends_on "KDE-mac/kde/kf5-kcoreaddons" => :build
  depends_on "KDE-mac/kde/kf5-kdbusaddons" => :build
  depends_on "KDE-mac/kde/kf5-kdnssd" => :build
  depends_on "KDE-mac/kde/kf5-kguiaddons" => :build
  depends_on "KDE-mac/kde/kf5-ki18n" => :build
  depends_on "KDE-mac/kde/kf5-kidletime" => :build
  depends_on "KDE-mac/kde/kf5-kirigami2" => :build
  depends_on "KDE-mac/kde/kf5-kitemmodels" => :build
  depends_on "KDE-mac/kde/kf5-kitemviews" => :build
  depends_on "KDE-mac/kde/kf5-kplotting" => :build
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons" => :build
  depends_on "KDE-mac/kde/kf5-kwindowsystem" => :build
  depends_on "KDE-mac/kde/kf5-solid" => :build
  depends_on "KDE-mac/kde/kf5-sonnet" => :build
  depends_on "KDE-mac/kde/kf5-syntax-highlighting" => :build
  depends_on "KDE-mac/kde/kf5-threadweaver" => :build

  def install
    touch "empty"
    prefix.install "empty"
  end

  def caveats; <<~EOS
      You need to take some manual steps in order to make this formula work:
      "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
  EOS
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      find_package(KF5Attica REQUIRED)
      find_package(ECM REQUIRED)
      find_package(KF5Archive REQUIRED)
      find_package(KF5Config REQUIRED)
      find_package(KF5Codecs REQUIRED)
      find_package(KF5CoreAddons REQUIRED)
      find_package(KF5DBusAddons REQUIRED)
      find_package(KF5DNSSD REQUIRED)
      find_package(KF5GuiAddons REQUIRED)
      find_package(KF5I18n REQUIRED)
      find_package(KF5IdleTime REQUIRED)
      find_package(KF5Kirigami2 REQUIRED)
      find_package(KF5ItemModels REQUIRED)
      find_package(KF5ItemViews REQUIRED)
      find_package(KF5Plotting REQUIRED)
      find_package(KF5WidgetsAddons REQUIRED)
      find_package(KF5WindowSystem REQUIRED)
      find_package(KF5Solid REQUIRED)
      find_package(KF5Sonnet REQUIRED)
      find_package(KF5SyntaxHighlighting REQUIRED)
      find_package(KF5ThreadWeaver REQUIRED)
    EOS
    system "cmake", ".", "-Wno-dev"
    # kf5-breeze-icons
    breeze = Formula["kf5-breeze-icons"].opt_share
    assert_predicate breeze/"icons/breeze/index.theme", :exist?
    assert_predicate breeze/"icons/breeze-dark/index.theme", :exist?
  end
end
