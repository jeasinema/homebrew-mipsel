require 'formula'

class MipselLinuxBinutils < Formula

    homepage 'http://www.gnu.org/software/binutils/binutils.html'
    url 'http://ftpmirror.gnu.org/binutils/binutils-2.27.tar.gz'
    mirror 'http://ftp.gnu.org/gnu/binutils/binutils-2.27.tar.gz'
    sha256 '26253bf0f360ceeba1d9ab6965c57c6a48a01a8343382130d1ed47c468a3094f'

    def install
        args = [
            "--target=mipsel-linux",
            "--prefix=#{prefix}",
            "--infodir=#{info}",
            "--mandir=#{man}",
            "--enable-interwork",
            "--enable-multilib",
            "--disable-debug",
            "--disable-dependency-tracking",
            "--disable-werror",
            "--disable-nls"
        ]

        mkdir 'build' do
            system "../configure", *args

            system "make"
            system "make", "install"
        end

        info.rmtree
    end
end
