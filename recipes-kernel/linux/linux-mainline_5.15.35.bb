require linux-mainline.inc

DESCRIPTION = "Mainline Longterm Linux kernel"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI[sha256sum] = "0a1a5ae2f30eb2b38215e59077f045aabd7f4e2857a881482f02ea48186105d8"


# # orangepi-zero-2 support added only for 5.15 kernel so add it to this recipe not to inc file
SRC_URI_append:orange-pi-zero2  = " \
        file://defconfig \
        file://0001-dts-add-h616-and-orangepizero2.patch \
        file://0002-drv-add-dump_reg-and-sunxi-sysinfo-drivers.patch \
        file://0003-drv-add-sunxi_get_soc_chipid-and-sunxi_get_serial.patch \
        file://0004-dts-add-sunxi-info-device-tree-node.patch \
        file://0005-dts-add-addr_mgt-device-tree-node.patch \
        file://0006-drv-modem-power-Power-manager-for-modems.patch \
        file://0007-drv-add-sunxi-addr-driver-used-to-fix-uwe5622-bluetooth-.patch \
        file://0008-drv-wireless-add-uwe5622-driver.patch \
        file://0009-drv-uwe5622-bluetooth-fix-firmware-init-fail.patch \
        file://0010-drv-fix-incldue-path-for-unisocwcn.patch \
"
