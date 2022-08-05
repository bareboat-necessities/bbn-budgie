#!/bin/bash -e

CONTAINER_DISTRO=$1

apt-get update  -y -q
apt-get install -y -q wget xz-utils gnupg ca-certificates
apt-get upgrade -y -q

apt-get -y install devscripts debhelper-compat build-essential lintian \
   gir1.2-gee-0.8 gnome-common gobject-introspection gtk-doc-tools libgee-0.8-dev libgnome-bluetooth-dev \
   libgnome-desktop-3-dev libgnome-menu-3-dev libgtk-3-dev libmutter-7-dev  libpeas-dev libpolkit-agent-1-dev \
   libpolkit-gobject-1-dev libupower-glib-dev libwnck-3-dev libgdk-pixbuf2.0-dev libaccountsservice-dev valac \
   gnome-settings-daemon-dev sassc libnotify-dev gnome-screensaver libgstreamer1.0-dev uuid-dev \
   libpulse-dev libpulse-mainloop-glib0 libglib2.0-dev libibus-1.0-dev meson libasound2-dev

#wget http://deb.debian.org/debian/pool/main/b/budgie-desktop/budgie-desktop_10.5.2.orig.tar.xz
#wget http://deb.debian.org/debian/pool/main/b/budgie-desktop/budgie-desktop_10.5.2-4.debian.tar.xz

#xzcat budgie-desktop_10.5.2.orig.tar.xz | tar xvf -
#cd budgie-desktop-10.5.2/
#xzcat ../budgie-desktop_10.5.2-4.debian.tar.xz | tar xvf -

wget https://launchpad.net/debian/+archive/primary/+sourcefiles/budgie-desktop/10.5.3-5/budgie-desktop_10.5.3-5.debian.tar.xz
wget https://launchpad.net/debian/+archive/primary/+sourcefiles/budgie-desktop/10.5.3-5/budgie-desktop_10.5.3.orig.tar.xz

xzcat budgie-desktop_10.5.3.orig.tar.xz | tar xvf -
cd budgie-desktop-10.5.3/
xzcat ../budgie-desktop_10.5.3-5.debian.tar.xz | tar xvf -

#cp ../debian/control debian/control

dpkg-buildpackage -uc -us -j8

cd ..

rm ./*dbgsym*.deb

