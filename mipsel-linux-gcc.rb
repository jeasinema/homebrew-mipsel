require 'formula'

class MipselLinuxGcc < Formula

    homepage 'http://www.gnu.org/software/gcc/gcc.html'
    url 'ftp://gcc.gnu.org/pub/gcc/releases/gcc-5.2.0/gcc-5.2.0.tar.bz2'
    mirror 'http://ftpmirror.gnu.org/gcc/gcc-5.2.0/gcc-5.2.0.tar.bz2'
    sha256 '5f835b04b5f7dd4f4d2dc96190ec1621b8d89f2dc6f638f9f8bc1b1014ba8cad'

    depends_on 'gmp'
    depends_on 'libmpc'
    depends_on 'mpfr'

    depends_on 'mipsel-linux-binutils'

    option 'disable-cxx', 'Don\'t build the g++ compiler'

    def install
        languages = %w[c]
        languages << 'c++' unless build.include? 'disable-cxx'

        args = [
            "--target=mipsel-linux",
            "--prefix=#{prefix}",

            "--enable-languages=#{languages.join(',')}",

            "--disable-nls",
            "--disable-shared",
            "--disable-threads",
            "--disable-libssp",
            "--disable-libstdcxx-pch",
            "--disable-libgomp",

            "--with-gnu-as",
            "--with-as=#{Formula["mipsel-linux-binutils"].opt_bin/'mipsel-linux-as'}",
            "--with-gnu-ld",
            "--with-ld=#{Formula["mipsel-linux-binutils"].opt_bin/'mipsel-linux-ld'}",
            "--with-gmp=#{Formula["gmp"].opt_prefix}",
            "--with-mpfr=#{Formula["mpfr"].opt_prefix}",
            "--with-mpc=#{Formula["libmpc"].opt_prefix}",
            "--with-system-zlib"
        ]

        mkdir 'build' do
            system "../configure", *args
            system "make", "all-gcc"
            system "make", "all-target-libgcc"

            ENV.deparallelize
            system "make", "install-gcc"
            system "make", "install-target-libgcc"
        end

        # info and man7 files conflict with native gcc
        info.rmtree
        man7.rmtree
    end
end
