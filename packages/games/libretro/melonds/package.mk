# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="melonds"
PKG_VERSION="1eebc828769f2619bd79f39545573a991391de5d"
PKG_REV="1"
PKG_LICENSE="GPLv3"
PKG_SITE="https://git.libretro.com/libretro/melonDS"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="MelonDS - Nintendo DS emulator for libretro"
PKG_TOOLCHAIN="make"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

pre_make_target() {

  cd ${PKG_BUILD}
  if [ -e "CMakeLists.txt" ]
  then
    rm CMakeLists.txt
  fi

  case ${DEVICE} in
    RG351P|RG351V|RG351MP)
      PKG_MAKE_OPTS_TARGET=" platform=odroidgoa"
    ;;
    RG552)
      PKG_MAKE_OPTS_TARGET=" platform=RK3399"
    ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp melonds_libretro.so $INSTALL/usr/lib/libretro/
}
