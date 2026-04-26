# compile meta-tegra on jetson-nano natively

This repo helped me to compile some oe4t meta-tegra packages directly on the jetson itself.

No promise to maintain any of this, feel free to fork.

Inspired by <https://github.com/hobble87/jetson-nano-yocto>

## Steps to compile tegra-egl-gbm support

```bash
#!/bin/bash
git checkout --recurse-submodules https://github.com/janesser/kirkstone-jetson-nano.git
cd kirkstone-jetson-nano

source poky/oe-init-build-env

bitbake -c clean world
bitbake libglvnd tegra-libraries-gbm tegra-libraries-core
sudo dpkg -i $(find tmp/deploy -name "*.deb")
sudo aptitude # get versions aligned

# conflicting file with unknown source package
sudo rm /usr/lib/aarch64-linux-gnu/tegra-egl/libEGL_nvidia.so.0

sudo dpkg --configure -a

ls /boot/Image* -al
    lrwxrwxrwx 1 root root       39 Jan 24 08:37 /boot/Image -> Image-4.9.337-l4t-r32.7.6+gd4116ecb5c13
    -rw-r--r-- 1 root root 38365192 Nov 28  2024 /boot/Image-4.9.337-l4t-r32.7.6+gd4116ecb5c13

sudo reboot
```

## setup local deb repo

<https://linuxconfig.org/easy-way-to-create-a-debian-package-and-local-package-repository>

## Getting devicetree right

Error from bitbake

```sh
| make -f /home/jan/projs/kirkstone-jetson-nano/build/tmp/work/jetson_nano_devkit-poky-linux/u-boot-tegra/1_2022.01+gAUTOINC+894fa67d7f-r0/git/scripts/Makefile.build obj=arch/arm/dts dtbs
| test -e arch/arm/dts/tegra210-p3450-0000.dtb || (                                             \
| echo >&2;                                                     \
| echo >&2 "Device Tree Source (arch/arm/dts/tegra210-p3450-0000.dtb) is not correctly specified.";     \
| echo >&2 "Please define 'CONFIG_DEFAULT_DEVICE_TREE'";                \
| echo >&2 "or build with 'DEVICE_TREE=<device_tree>' argument";        \
| echo >&2;                                                     \
| /bin/false)
```

```sh
cat /proc/device-tree/compatible
nvidia,p3449-0000-b00+p3448-0000-b00nvidia,jetson-nanonvidia,tegra210⏎
```

Figuring what is running

```sh
cat /proc/device-tree/compatible

# nvidia,p3449-0000-b00+p3448-0000-b00nvidia,jetson-nanonvidia,tegra210⏎
```

<https://github.com/OE4T/meta-tegra/commit/f95e7d11dc833caf94ae89e7960251fae4798e26>

## Further ressources

<https://github.com/orgs/OE4T/discussions/1593>
<https://marcopennelli.com/embedded-linux-yocto-project-and-nvidia-jetson-nano-developer-kit-episode-1-369c079b7c15>
