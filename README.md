# Набор файлов для установки и настройки ArchLinux

## Установка

Загружаемся в archiso, далее:

```bash
# Узнаём список дисков
lblsk

# Устанавливаем wifi соединение
iwctl station wlan0 connect wifi_network_name

# Установливаем wget
pacman -S --noconfirm wget

# Скачиваем и запускаем arch-1.sh
wget -O - https://raw.githubusercontent.com/jonathanblade/arch/main/arch-1.sh disk_name | sh
```
При разметке диска (например, /dev/nvme0n1) создаём две партиции:
1. EFI (512MB)
2. Linux Filesystem (всё оставшееся место)

## Настройка

**Grub** установить `GRUB_TIMEOUT=0` и `GRUB_CMDLINE_LINUX_DEFAULT=""` в `/etc/default/grub`, затем обновить конфиг `sudo grub-mkconfig -o /boot/grub/grub.cfg`
