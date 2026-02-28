# compile meta-tegra on jetson-nano natively

This repo helped me to compile some oe4t meta-tegra packages directly on the jetson itself.

No promise to maintain any of this, feel free to fork.

Inspired by <https://github.com/hobble87/jetson-nano-yocto>

## Steps to compile tegra-egl-gbm support

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

## setup local deb repo

<https://linuxconfig.org/easy-way-to-create-a-debian-package-and-local-package-repository>

## Further ressources
<https://github.com/orgs/OE4T/discussions/1593>
<https://marcopennelli.com/embedded-linux-yocto-project-and-nvidia-jetson-nano-developer-kit-episode-1-369c079b7c15>
