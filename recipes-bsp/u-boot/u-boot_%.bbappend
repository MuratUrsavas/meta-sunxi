FILESEXTRAPATHS:prepend:sunxi := "${THISDIR}/files:"

DEPENDS_append:sunxi = " bc-native dtc-native swig-native python3-native flex-native bison-native "
DEPENDS_append:sun50i = " atf-sunxi "

COMPATIBLE_MACHINE:sunxi = "(sun4i|sun5i|sun7i|sun8i|sun50i)"

DEFAULT_PREFERENCE:sun4i = "1"
DEFAULT_PREFERENCE:sun5i = "1"
DEFAULT_PREFERENCE:sun7i = "1"
DEFAULT_PREFERENCE:sun8i = "1"
DEFAULT_PREFERENCE:sun50i = "1"

SRC_URI_append:sunxi = " \
        file://0001-nanopi_neo_air_defconfig-Enable-eMMC-support.patch \
	file://0002-Added-nanopi-r1-board-support.patch \
	file://0003-Add-nanopi-duo2-board-support.patch \
	file://0004-i2c-mvtwsi-Add-compatible-string-for-allwinner-sun4i.patch \
        file://boot.cmd \
"

UBOOT_ENV_SUFFIX:sunxi = "scr"
UBOOT_ENV:sunxi = "boot"

EXTRA_OEMAKE_append:sunxi = ' HOSTLDSHARED="${BUILD_CC} -shared ${BUILD_LDFLAGS} ${BUILD_CFLAGS}" '
EXTRA_OEMAKE_append:sun50i = " BL31=${DEPLOY_DIR_IMAGE}/bl31.bin SCP=/dev/null"

do_compile_sun50i[depends] += "atf-sunxi:do_deploy"

do_compile_append:sunxi() {
    ${B}/tools/mkimage -C none -A arm -T script -d ${WORKDIR}/boot.cmd ${WORKDIR}/${UBOOT_ENV_BINARY}
}
