
class ApacheArrowGlib < Formula
    desc "GObject Introspection files of Apache Arrow"
    homepage "https://arrow.apache.org/"
    url "https://www.apache.org/dyn/closer.cgi?path=arrow/arrow-0.8.0/apache-arrow-0.8.0.tar.gz"
    sha256 "b142b883c7107485a296655e8d7421d11891acbca15862f37a4a8c1b13d4e9c4"
    head "https://github.com/apache/arrow.git"
  
    depends_on "pkg-config" => :build
    depends_on "gobject-introspection" => :build
    depends_on "apache-arrow"
    depends_on "gettext"
    depends_on "glib"
  
    def install
      cd "c_glib" do
        system "./configure", "--prefix=#{prefix}"
        system "make"
        system "make", "install"
      end
    end
  
    test do
      (testpath/"test.c").write <<~EOS
        #include <arrow-glib/arrow-glib.h>
  
        int main(int argc, char **argv){
          GArrowArray *array;
          return 0;
        }
      EOS
      system ENV.cc, "test.c", "-o", "test"
      system "./test"
    end
  end
  