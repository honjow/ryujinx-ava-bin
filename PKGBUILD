# Maintainer: honjow

pkgname=ryujinx-ava-bin
pkgver=1.1.1248
pkgrel=1
pkgdesc='Experimental Nintendo Switch Emulator written in C# (master build channel release, test ava build)'
arch=(x86_64)
url='https://github.com/Ryujinx/release-channel-master'
license=('MIT')
depends=('dotnet-runtime')
provides=(ryujinx-ava)
conflicts=(ryujinx-ava Ryujinx-ava)
options=('!strip')
source=("${url}/releases/download/${pkgver}/test-ava-ryujinx-${pkgver}-linux_x64.tar.gz"
        'https://raw.githubusercontent.com/Ryujinx/Ryujinx/master/distribution/linux/Ryujinx.desktop'
        'https://raw.githubusercontent.com/Ryujinx/Ryujinx/master/distribution/misc/Logo.svg')

b2sums=('SKIP'
        'aaf7e9ddc24bc0068d75a4136262ab2e7f669acda91b7abc66ac5c8d6332804af45b5f9eec43d1d5541dc8e7944001362fbb67bec873fffde496c6c46d6500fc'
        'f96fe6146018fd869c55e413b2cc6cf12f17c5257af52df14f57978133792c7fb76e8526b15a5120dbf12a9fed7b8e4723a3ff9f2e45b613b10ee1017ba0b996')

package() {
        mkdir --parents "${pkgdir}/opt"
        cp --recursive "${srcdir}/publish" "${pkgdir}/opt/ryujinx-ava"
        chmod +x "${pkgdir}/opt/ryujinx-ava/Ryujinx.Ava"

        # create writable logs directory
        install --directory --mode=777 "${pkgdir}/opt/ryujinx-ava/Logs"

        mkdir --parents "${pkgdir}/usr/bin"
        ln --symbolic "/opt/ryujinx-ava/Ryujinx.Ava" "${pkgdir}/usr/bin/Ryujinx.Ava"

        # replace 'Ryujinx %f' to 'Ryujinx.Ava %f' in Ryujinx.desktop
        sed --in-place 's/Ryujinx %f/Ryujinx.Ava %f/' "${srcdir}/Ryujinx.desktop"

        # replace 'Name=Ryujinx' to 'Name=Ryujinx Ava' in Ryujinx.desktop
        sed --in-place 's/Name=Ryujinx/Name=Ryujinx Ava/' "${srcdir}/Ryujinx.desktop"

        # replace 'Icon=Ryujinx' to 'Icon=Ryujinx-ava' in Ryujinx.desktop
        sed --in-place 's/Icon=Ryujinx/Icon=Ryujinx-ava/' "${srcdir}/Ryujinx.desktop"

        # replace 'Exec=env ' to 'Exec=env LC_ALL=C ' in Ryujinx.desktop
        sed --in-place 's/Exec=env /Exec=env LC_ALL=C /' "${srcdir}/Ryujinx.desktop"

        install -D "${srcdir}/Ryujinx.desktop" "${pkgdir}/usr/share/applications/Ryujinx-ava.desktop"
        install -D "${srcdir}/Logo.svg" "${pkgdir}/usr/share/icons/hicolor/scalable/apps/Ryujinx-ava.svg"
}