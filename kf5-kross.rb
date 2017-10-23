require "formula"

class Kf5Kross < Formula
  desc "Multi-language application scripting"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/portingAids/kross-5.39.0.tar.xz"
  sha256 "d06ddc6157e150ea91be0f790df35a2e14239de0179f0cd8f048ad93597c09be"

  head "git://anongit.kde.org/kross.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{prefix}/bin"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      mkdir -p "~/Applications/KDE"
      ln -sf "#{prefix}/bin/kf5kross.app" "~/Applications/KDE/"
    EOS
  end
end
