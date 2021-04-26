#!/bin/sh

efi_partition=$1

# Часовой пояс
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc --utc

# Локализация
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Настройка сети
echo "archpad" > /etc/hostname
echo "127.0.0.1 localhost" > /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 archpad.localdomain archpad" >> /etc/hosts

# Пароль для root
passwd

# Grub
pacman -S --noconfirm grub efibootmgr intel-ucode
mkdir -p /boot/EFI/
mount ${efi_partition} /boot/EFI/
grub-install --target=x86_64-efi
grub-mkconfig -o /boot/grub/grub.cfg

# Пользователь sam
pacman -S --noconfirm zsh
useradd -m -g users -s /bin/zsh sam
passwd sam
echo "sam ALL=(ALL) ALL" >> /etc/sudoers

# Xorg server
pacman -S --noconfirm xorg-server 

# Drivers
pacman -S --noconfirm xf86-video-intel xf86-input-libinput mesa vulkan-intel intel-media-driver

# Desktop environment
pacman -S --noconfirm gnome

# Services
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable gd
