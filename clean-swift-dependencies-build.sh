#!/bin/bash
set -ex

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
$SCRIPT_DIR/build.sh bitbake -c cleansstate swift-hello-world \
quilt-native patch-native binutils-cross-arm pseudo-native rpm-native dwarfsrcfiles-native opkg-utils-native zstd-native unzip-native \
swift-native swift-stdlib swift-testing swift-foundation gcc-cross-arm gcc-runtime swift-xctest libgcc glibc gcc libdispatch ncurses-native \
swift-foundation-essentials linux-libc-headers autoconf-native automake-native libtool-native attr-native texinfo-dummy-native bison-native \
pkgconfig-native gnu-config-native flex-native zlib-native xz-native sqlite3-native python3-native libgcrypt-native popt-native \
gettext-minimal-native bzip2-native cmake-native lua-native elfutils-native file-native perl-native curl ninja-native icu libxml2-native ncurses \
libxml2 swift-foundation-icu gcc-source-13.4.0 mpfr-native libmpc-native gmp-native gperf-native libgcc-initial gmp mpfr zlib libtool-cross zstd \
libmpc gettext-native unifdef-native rsync-native m4-native python3 util-linux-libuuid-native autoconf-archive-native libedit-native \
openssl-native libffi-native gdbm-native expat-native libtirpc-native libnsl2-native libgpg-error-native libcap-native readline-native \
curl-native libarchive-native libmicrohttpd-native lzlib-native perlcross-native make-native openssl opkg-utils libidn2 re2c-native icu-native \
acl-native libffi libxcrypt sqlite3 bzip2 libnsl2 xz libedit util-linux-libuuid expat gdbm libtirpc e2fsprogs-native gnutls-native \
libunistring gtk-doc-native util-linux-native libpcre2-native nettle-native libunistring-native libtasn1-native libidn2-native libcap-ng-native

$SCRIPT_DIR/build.sh bitbake core-image-minimal

