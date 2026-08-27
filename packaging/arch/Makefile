.PHONY: package install clean

package:
	makepkg --syncdeps --cleanbuild

install:
	makepkg --syncdeps --install --cleanbuild

clean:
	rm -rf pkg src ubuntu-shell-*.pkg.tar.zst
