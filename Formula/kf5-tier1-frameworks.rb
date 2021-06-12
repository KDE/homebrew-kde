require_relative "../lib/cmake"

class Kf5Tier1Frameworks < Formula
  desc "Metapackage for Tier 1 KF5 frameworks"
  homepage "https://api.kde.org/frameworks"
  system "touch", "/tmp/empty"
  url "file:///tmp/empty"
  version "5.83.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "karchive" => [:build, :test]
  depends_on "kde-mac/kde/kf5-attica" => [:build, :test]
  depends_on "kde-mac/kde/kf5-breeze-icons" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kapidox" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kcodecs" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kconfig" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kcoreaddons" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kdbusaddons" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kdnssd" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kguiaddons" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kidletime" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kirigami2" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kitemmodels" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kitemviews" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kplotting" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kwidgetsaddons" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kwindowsystem" => [:build, :test]
  depends_on "kde-mac/kde/kf5-qqc2-desktop-style" => [:build, :test]
  depends_on "kde-mac/kde/kf5-solid" => [:build, :test]
  depends_on "kde-mac/kde/kf5-sonnet" => [:build, :test]
  depends_on "kde-mac/kde/kf5-syntax-highlighting" => [:build, :test]
  depends_on "ki18n" => [:build, :test]
  depends_on "threadweaver" => [:build, :test]

  def install
    touch "empty"
    prefix.install "empty"
  end

  def caveats
    <<~EOS
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
