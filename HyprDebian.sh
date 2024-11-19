#!/bin/bash

# Приветствие
echo ""
echo ""
echo ""
echo ""
echo ""
echo "-----------------------------------"
echo -e "\e[32mHi bro, thanks for using my script for installation Hyprland on Debian!\e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""
# Убедитесь, что скрипт выполняется с правами администратора
if [[ $EUID -ne 0 ]]; then
   echo -e "\e[32mBro, let him go root\e[0m"
   exit 1
fi


# Обновление и установка зависимостей
echo ""
echo ""
echo ""
echo ""
echo ""
echo "-----------------------------------"
echo -e "\e[32mI update the system and install dependencies\e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""
apt update

apt upgrade -y

apt-get install -y meson wget build-essential ninja-build cmake-extras cmake gettext gettext-base fontconfig libfontconfig-dev libffi-dev libxml2-dev libdrm-dev libxkbcommon-x11-dev libxkbregistry-dev libxkbcommon-dev libpixman-1-dev libudev-dev libseat-dev seatd libxcb-dri3-dev libvulkan-dev libvulkan-volk-dev  vulkan-utility-libraries-dev libvkfft-dev libgulkan-dev libegl-dev libgles2 libegl1-mesa-dev glslang-tools libinput-bin libinput-dev libxcb-composite0-dev libavutil-dev libavcodec-dev libavformat-dev libxcb-ewmh2 libxcb-ewmh-dev libxcb-present-dev libxcb-icccm4-dev libxcb-render-util0-dev libxcb-res0-dev libxcb-xinput-dev libpugixml-dev libzip-dev librsvg2-dev libtomlplusplus-dev libgbm-dev libxcursor-dev libxcb-errors-dev xwayland polkitd libnvidia-egl-wayland1 libnvidia-egl-gbm1 libliftoff0 libudis86-0 gcc clang hwdata libglm-dev libbenchmark-dev liblcms2-dev libxmu-dev libxcursor-dev libeis-dev libpixman-1-dev libx11-dev libxdamage-dev libxcomposite-dev libxrender-dev libxext-dev libxfixes-dev libxxf86vm-dev libxtst-dev libxres-dev libdrm-dev libvulkan-dev libxkbcommon-dev libsdl2-dev libpipewire-0.3-dev libavif-dev libwlroots-dev libliftoff-dev libcap-dev spirv-headers libstb-dev libdecor-0-dev libxdamage-dev git glslang-tools vulkan-tools libexpat1-dev libxml2-dev graphviz doxygen xsltproc xmlto 

echo ""
echo ""
echo ""
echo ""
echo ""
echo "-----------------------------------"
echo -e "\e[32mInstall SDDM without KDE\e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""   

apt --no-install-recommends install sddm -y

mkdir HyprDebian

cd HyprDebian

echo ""
echo ""
echo ""
echo ""
echo ""
echo "-----------------------------------"
echo -e "\e[32mBild edid-decode\e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""  

git clone git://linuxtv.org/edid-decode.git

cd edid-decode

meson setup build

meson compile -C build

meson install -C build

cd ../..

echo ""
echo ""   
echo ""
echo ""
echo ""
echo "-----------------------------------"
echo -e "\e[32m Install Wayland \e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""

wget https://gitlab.freedesktop.org/wayland/wayland/-/releases/1.23.1/downloads/wayland-1.23.1.tar.xz

mkdir build &&
cd    build &&

meson setup ..            \
      --prefix=/usr       \
      --buildtype=release &&
ninja

ninja install

cd ../..

echo ""
echo ""   
echo ""
echo ""   
echo ""
echo "-----------------------------------"
echo -e "\e[32mInstall Wayland-Protocols\e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""

wget https://gitlab.freedesktop.org/wayland/wayland-protocols/-/releases/1.38/downloads/wayland-protocols-1.38.tar.xz

tar -xvJf wayland-protocols-1.38.tar.xz

cd wayland-protocols-1.38

mkdir build &&
cd    build &&

meson setup --prefix=/usr --buildtype=release &&
ninja

ninja install

cd ../..

echo ""
echo ""   
echo ""
echo ""   
echo ""
echo "-----------------------------------"
echo -e "\e[32mInstall Libdisplay-info\e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""

wget https://gitlab.freedesktop.org/emersion/libdisplay-info/-/releases/0.2.0/downloads/libdisplay-info-0.2.0.tar.xz

tar -xvJf libdisplay-info-0.2.0.tar.xz

cd libdisplay-info-0.2.0

meson setup build/

ninja -C build/

ninja -C build/ install

cd ..

echo ""
echo ""   
echo ""
echo ""   
echo ""
echo "-----------------------------------"
echo -e "\e[32mInstall Wlroots\e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""

wget https://gitlab.freedesktop.org/wlroots/wlroots/-/releases/0.18.1/downloads/wlroots-0.18.1.tar.gz

tar -xvf wlroots-0.18.1.tar.gz

cd wlroots-0.18.1

meson setup build/

ninja -C build/

sudo ninja -C build/ install

cd ..

echo ""
echo ""   
echo ""
echo ""   
echo ""
echo "-----------------------------------"
echo -e "\e[32mInstall HyprWayland-scanner\e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""

git clone https://github.com/hyprwm/hyprwayland-scanner.git

cd hyprwayland-scanner

cmake -DCMAKE_INSTALL_PREFIX=/usr -B build

cmake --build build -j `nproc`

cmake --install build

cd ..

echo ""
echo ""   
echo ""
echo ""   
echo ""
echo "-----------------------------------"
echo -e "\e[32mInstall HyprUtils\e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""

git clone https://github.com/hyprwm/hyprutils.git

cd hyprutils

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build

cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

cmake --install build

cd ..

echo ""
echo ""   
echo ""
echo ""   
echo ""
echo "-----------------------------------"
echo -e "\e[32mInstall HyprLang\e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""

git clone https://github.com/hyprwm/hyprlang.git

cd hyprlang

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build

cmake --build ./build --config Release --target hyprlang -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

cmake --install ./build

cd ..

echo ""
echo ""   
echo ""
echo ""   
echo ""
echo "-----------------------------------"
echo -e "\e[32mInstall HyprCursor\e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""

git clone https://github.com/hyprwm/hyprcursor.git

cd hyprcursor

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build

cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

cmake --install build

cd ..

echo ""
echo ""   
echo ""
echo ""   
echo ""
echo "-----------------------------------"
echo -e "\e[32mInstall Aquamarine\e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""

git clone https://github.com/hyprwm/aquamarine.git

cd aquamarine

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build

cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

cmake --install build

cd ..

echo ""
echo ""   
echo ""
echo ""   
echo ""
echo "-----------------------------------"
echo -e "\e[32mAnd finally, the installation Hyprland\e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""

wget https://github.com/hyprwm/Hyprland/releases/download/v0.45.1/source-v0.45.1.tar.gz

tar -xvf source-v0.45.1.tar.gz

cd hyprland-source 

make all  

make install

cd

rm -r HyprDebian

echo ""
echo ""   
echo ""
echo ""   
echo ""
echo "-----------------------------------"
echo -e "\e[32mUseful dependencies (kitty, wofi and hyprpaper)\e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""

apt-get install kitty wofi hyprpaper -y


echo ""
echo ""   
echo ""
echo ""   
echo ""
echo "-----------------------------------"
echo -e "\e[32mThank you for using my script. I hope the installation went smoothly!\e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""
echo "-----------------------------------"
echo -e "\e[32mEnjoy using<3\e[0m"
echo "-----------------------------------"
echo ""
echo ""
echo ""
echo ""
echo ""
