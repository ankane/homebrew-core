class Cimgui < Formula
  desc "C API for Dear ImGui"
  homepage "https://github.com/cimgui/cimgui"
  url "https://github.com/cimgui/cimgui.git",
      tag:      "1.78",
      revision: "90ddbc37b02679597af05d264265434f113fa185"
  license "MIT"

  def install
    system "make"
    lib.install "cimgui.dylib"
    lib.install_symlink "cimgui.dylib" => "libcimgui.dylib"
    include.install "cimgui.h"
    pkgshare.install "test"
  end

  test do
    cp pkgshare/"test/main.c", testpath
    inreplace "main.c", "../cimgui.h", "cimgui.h"
    system ENV.cc, "main.c", "-I#{include}", "-L#{lib}", "-lcimgui",
                   "-o", "test", "-DCIMGUI_DEFINE_ENUMS_AND_STRUCTS=1"
    assert_match "CreateContext() - v#{version}", shell_output("./test")
  end
end
