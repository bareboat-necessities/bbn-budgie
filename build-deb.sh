#!/bin/bash -e

CONTAINER_DISTRO=$1

apt-get update  -y -q
apt-get install -y -q wget xz-utils gnupg ca-certificates
apt-get upgrade -y -q

apt-get -y install devscripts build-essential lintian \
   gir1.2-gee-0.8 gnome-common gobject-introspection gtk-doc-tools libgee-0.8-dev libgnome-bluetooth-dev \
   libgnome-desktop-3-dev libgnome-menu-3-dev libgtk-3-dev libmutter-3-dev  libpeas-dev libpolkit-agent-1-dev \
   libpolkit-gobject-1-dev libupower-glib-dev libwnck-3-dev libgdk-pixbuf2.0-dev libaccountsservice-dev valac \
   gnome-settings-daemon-dev sassc libnotify-dev \
   libpulse-dev libpulse-mainloop-glib0 libibus-1.0-dev meson libasound2-dev

wget http://deb.debian.org/debian/pool/main/b/budgie-desktop/budgie-desktop_10.5.orig.tar.xz
wget http://deb.debian.org/debian/pool/main/b/budgie-desktop/budgie-desktop_10.5-1.debian.tar.xz

xzcat budgie-desktop_10.5.orig.tar.xz | tar xvf -

cd budgie-desktop-10.5/

xzcat ../budgie-desktop_10.5-1.debian.tar.xz | tar xvf -

patch -p0 --verbose --force < ../Replace_na-tray_with_carbontray_1998.patch || true
cp ../src/applets/tray/TrayApplet.vala src/applets/tray/TrayApplet.vala
cp ../src/applets/tray/carbontray/child.c src/applets/tray/carbontray/child.c
cp ../src/applets/tray/carbontray/tray.c src/applets/tray/carbontray/tray.c

EDITOR=/bin/true dpkg-source -q --commit . Replace_na_tray_with_carbontray_patch
debuild -us -uc

cd ..

rm ./*dbgsym*.deb

