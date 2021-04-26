#!/bin/sh

ssd=$1
efi_partition=$1p1
root_partition=$1p2

# Разметка диска
gdisk ${ssd}

# Создание файловой системы
mkfs.fat -F32 ${efi_partition}
mkfs.btrfs -f -L ArchLinux ${root_partition}

# Монтирование
mount ${root_partition} /mnt

# Список зеркал для pacman
echo -e "Server = https://mirror.yandex.ru/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
echo -e "Server = https://mirror.truenetwork.ru/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
echo -e "Server = https://mirror.nw-sys.ru/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
echo -e "Server = https://mirror.surf/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist

# Установка системы
pacstrap /mnt base base-devel linux linux-headers linux-firmware btrfs-progs

# Генерация fstab
genfstab -U -p /mnt >> /mnt/etc/fstab

# Выполнение arch-2.sh
wget https://raw.githubusercontent.com/jonathanblade/arch/main/arch-2.sh -O /mnt/arch-2.sh
arch-chroot /mnt sh arch-2.sh ${efi_partition}
