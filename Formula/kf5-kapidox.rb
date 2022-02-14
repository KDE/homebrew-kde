require_relative "../lib/cmake"

class Kf5Kapidox < Formula
  include Language::Python::Virtualenv

  desc "Frameworks API Documentation Tools"
  homepage "https://api.kde.org/frameworks/kapidox/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.91/kapidox-5.91.0.tar.xz"
  sha256 "434daaf49056471af72a97043c054d0104f1341f92a4464f66a2256233a2b7f7"
  head "https://invent.kde.org/frameworks/kapidox.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build
  depends_on "qt@5" => :build

  depends_on "python@3.10"

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/91/a5/429efc6246119e1e3fbf562c00187d04e83e54619249eb732bb423efa6c6/Jinja2-3.0.3.tar.gz"
    sha256 "611bb273cd68f3b993fabdc4064fc858c5b47a973cb5aa7999ec1ba405c87cd7"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/bf/10/ff66fea6d1788c458663a84d88787bae15d45daa16f6b3ef33322a51fc7e/MarkupSafe-2.0.1.tar.gz"
    sha256 "594c67807fb16238b30c44bdf74f36c02cdf22d1c8cda91ef8a0ed8dabf5620a"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/36/2b/61d51a2c4f25ef062ae3f74576b01638bebad5e045f747ff12643df63844/PyYAML-6.0.tar.gz"
    sha256 "68fb519c14306fec9720a2a5b45bc9f0c8d1b9c72adf45c37baedfcd949c35a2"
  end

  def install
    version = Language::Python.major_minor_version Formula["python@3.10"].bin/"python3"
    ENV["PYTHONPATH"] = lib/"python#{version}/site-packages"
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python#{version}/site-packages"

    resources.each do |r|
      r.stage do
        system Formula["python@3.10"].bin/"python3", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    args = kde_cmake_args
    args << ("-DPYTHON_EXECUTABLE=" + Formula["python@3.10"].bin + "/python3")

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"

    bin.env_script_all_files(libexec/"bin", PYTHONPATH: ENV["PYTHONPATH"])
  end

  test do
    assert_match "help", shell_output("#{bin}/kapidox_generate --help")
  end
end
