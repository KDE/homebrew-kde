require "formula"

class Kf5Kitemmodels < Formula
  desc "Models for Qt Model/View system"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kitemmodels-5.39.0.tar.xz"
  sha256 "699a1e7e1c78159efb501afc197f9b9959a800405da1ed9de9115ea13c98c0ae"

  head "git://anongit.kde.org/kitemmodels.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
