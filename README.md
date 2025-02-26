meta-sunxi
==============

Official sunxi OpenEmbedded layer for Allwinner-based boards.

This layer depends on the additional layers:

* [meta-openembedded/meta-oe](http://git.openembedded.org/meta-openembedded/tree/meta-oe)

Tested with core-image-base.

Maintainers:

* Nicolas Aguirre <aguirre.nicolas@gmail.com>
* Enrico Butera <ebutera@users.sourceforge.net>
* Sergey Lapin <slapin@ossfans.org>
* Marek Belisko <marek.belisko@gmail.com>

Community
===========

You can reach community + ask your question on gitter: https://matrix.to/#/#meta-sunxi:gitter.im

Kernel / U-Boot Version
===========
Most Allwinner devices and hardware are supported in mainline kernel and U-Boot, so this layer builds mainline by default.

Legacy sunxi Kernel / U-Boot
-----------

There is a custom U-Boot and Kernel version for sunxi devices which includes some special drivers not mainlined.
These versions are rather old (3.4 for kernel and 2014.04 for U-Boot), but may support more functions and devices than current mainline.

If you want to switch back to sunxi versions for some reasons (no device tree available, unsupported hardware), either:
- change the file conf/machine/include/sunxi.inc to include the following block
- edit your conf/local.conf to add the following block

		PREFERRED_PROVIDER_u-boot="u-boot-sunxi"
		PREFERRED_PROVIDER_virtual/bootloader="u-boot-sunxi"
		PREFERRED_PROVIDER_virtual/kernel="linux-sunxi"
		KERNEL_DEVICETREE = ""

If you already have built the mainline versions it might be necessary to reset the build directories with:

	bitbake -c clean virtual/kernel virtual/bootloader

Mainline Kernel / U-Boot
-----------

For mainline kernel we have now support for latest LTS and stable.
By default we use latest LTS. If you would like to change version please update ```PREFERRED_VERSION_linux-mainline``` in:
* [conf/machine/include/sunxi.inc](https://github.com/linux-sunxi/meta-sunxi/blob/fa0846c0eb23e3424b89acb4d5a327e921f73497/conf/machine/include/sunxi.inc#L16)

When using mainline kernel ≥ 5.2 it is now possible to use the mainline graphics drivers *lima* and *panfrost*, instead of the *mali* driver provided by ARM. To enable open source mainline graphics support add the following line in your `local.conf`:

    MACHINEOVERRIDES .= ":use-mailine-graphics"

Performance
===========
The default machine settings are meant to be the lowest common denominator, maximizing generality.
Significantly better performance (2x-3x) can be achieved with the following settings:

**_Allwinner A20_**

For Allwinner A20 (Cubieboard2/CubieTruck), the following tuning options are recommended:

_Enable hardfloat, thumb2 and neon capabilities_

	DEFAULTTUNE = "cortexa7hf-neon-vfpv4"

This tuning profile takes advantage of the Allwinner A20 hardfloat, neon and vfpv4 capabilities.

_Change CPU governor to ondemand, and tune settings_

	echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
	echo 336000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 912000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	#More aggressive
	#echo 1008000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo 40 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
	echo 200000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate

This code changes the default CPU governor from _fantasy_ to _ondemand_, and tunes its settings, as recommended at http://linux-sunxi.org/Cpufreq

For additional discussion, see https://github.com/linux-sunxi/meta-sunxi/issues/25


