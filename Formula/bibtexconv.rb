class Bibtexconv < Formula
  desc "BibTeX Converter"
  homepage "https://www.nntb.no/~dreibh/bibtexconv/"
  url "https://www.nntb.no/~dreibh/bibtexconv/download/bibtexconv-2.2.4.tar.xz"
  sha256 "1fc6a8998e7f4e42f349aef5711a341742783bd8f2a7366c85b0b66e18bec4bc"
  license "GPL-3.0-or-later"

  depends_on "bison" => :build
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  depends_on "curl"
  depends_on "openssl@3"
  depends_on "poppler"
  depends_on "python@3.12"

  def install
    # Remove trailing /examples subdirectory added by upstream CMakeLists
    inreplace ["src/CMakeLists.txt", "src/Images/CMakeLists.txt"], "/examples", ""

    args = std_cmake_args + %W[
      -DCMAKE_MACOSX_RPATH=ON
      -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
      -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"bibtexconv", "--version"
  end
end
