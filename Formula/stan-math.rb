class StanMath < Formula
  desc "C++, reverse-mode automatic differentiation library"
  homepage "https://github.com/stan-dev/math/"
  url "https://github.com/stan-dev/math/archive/v3.4.0.tar.gz"
  sha256 "3e768d1c2692543d3560f9d954d19e58fd14c9aaca22f5140c9f7f1437ddccf9"
  license all_of: ["BSD-3-Clause", "BSL-1.0", "LGPL-3.0-or-later", "Apache-2.0"]

  def install
    system "make", "-f", "make/standalone", "math-libs"
    libexec.install Dir["*"]
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <stan/math.hpp>
      #include <iostream>

      int main() {
        std::cout << "log normal(1 | 2, 3)="
                  << stan::math::normal_log(1, 2, 3)
                  << std::endl;
      }
    EOS
    system "make", "-f", "#{libexec}/make/standalone", "test"
    assert_match "log normal(1 | 2, 3)=-2.07311", shell_output("./test")
  end
end
