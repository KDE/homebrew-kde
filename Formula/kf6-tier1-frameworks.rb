require_relative "../lib/cmake"

class Kf6Tier1Frameworks < Formula
  desc "Metapackage for Tier 1 KF6 frameworks"
  homepage "https://api.kde.org/frameworks"
  system "touch", "/tmp/empty"
  url "file:///tmp/empty"
  version "6.5.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  livecheck do
    skip "Meta package"
  end

  depends_on "extra-cmake-modules"
  depends_on "karchive"
  depends_on "kde-mac/kde/kf6-attica"
  depends_on "kde-mac/kde/kf6-breeze-icons"
  depends_on "kde-mac/kde/kf6-kcodecs"
  depends_on "kde-mac/kde/kf6-kconfig"
  depends_on "kde-mac/kde/kf6-kcoreaddons"
  depends_on "kde-mac/kde/kf6-kdbusaddons"
  depends_on "kde-mac/kde/kf6-kdnssd"
  depends_on "kde-mac/kde/kf6-kguiaddons"
  depends_on "kde-mac/kde/kf6-kidletime"
  depends_on "kde-mac/kde/kf6-kirigami"
  depends_on "kde-mac/kde/kf6-kitemmodels"
  depends_on "kde-mac/kde/kf6-kitemviews"
  depends_on "kde-mac/kde/kf6-kplotting"
  depends_on "kde-mac/kde/kf6-kwidgetsaddons"
  depends_on "kde-mac/kde/kf6-kwindowsystem"
  depends_on "kde-mac/kde/kf6-qqc2-desktop-style"
  depends_on "kde-mac/kde/kf6-solid"
  depends_on "kde-mac/kde/kf6-sonnet"
  depends_on "kde-mac/kde/kf6-syntax-highlighting"
  depends_on "ki18n"
  depends_on "threadweaver"

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
      find_package(ECM REQUIRED)
      find_package(KF6Archive REQUIRED)
      find_package(KF6Attica REQUIRED)
      find_package(KF6Config REQUIRED)
      find_package(KF6Codecs REQUIRED)
      find_package(KF6CoreAddons REQUIRED)
      find_package(KF6DBusAddons REQUIRED)
      find_package(KF6DNSSD REQUIRED)
      find_package(KF6GuiAddons REQUIRED)
      find_package(KF6IdleTime REQUIRED)
      find_package(KF6Kirigami REQUIRED)
      find_package(KF6ItemModels REQUIRED)
      find_package(KF6ItemViews REQUIRED)
      find_package(KF6Plotting REQUIRED)
      find_package(KF6WidgetsAddons REQUIRED)
      find_package(KF6WindowSystem REQUIRED)
      find_package(KF6QQC2DeskopStyle REQUIRED)
      find_package(KF6Solid REQUIRED)
      find_package(KF6Sonnet REQUIRED)
      find_package(KF6SyntaxHighlighting REQUIRED)
      find_package(KF6I18n REQUIRED)
      find_package(KF6ThreadWeaver REQUIRED)
    EOS
    system "cmake", ".", "-Wno-dev"
    # kf6-breeze-icons
    breeze = Formula["kf6-breeze-icons"].opt_share
    assert_predicate breeze/"icons/breeze/index.theme", :exist?
    assert_predicate breeze/"icons/breeze-dark/index.theme", :exist?
  end
end
