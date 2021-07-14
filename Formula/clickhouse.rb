class Clickhouse < Formula
  desc "Analytics DBMS for big data"
  homepage "https://clickhouse.tech"
  # url "https://github.com/ClickHouse/ClickHouse/archive/v20.3.11.97-lts.tar.gz"
  # sha256 "f59b554823cda180eba86a09756555f52d10bd0875176f7028894b4923c22ba0"
  url "https://github.com/ClickHouse/ClickHouse.git",
      :tag      => "v20.3.11.97-lts",
      :revision => "bc590a24ae36e355126e0b967f78849c21997cf1"

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
    fork { exec bin/"clickhouse-server" }
    sleep 5
    system bin/"clickhouse-client"
  end
end
