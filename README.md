# Набор файлов для установки ArchLinux

Загружаемся в archiso, далее:
```bash
# Узнаём список дисков
lblsk

# Устанавливаем wifi соединение
iwctl station wlan0 connect wifi_network_name

# Установливаем wget
pacman -S --noconfirm wget

# Скачиваем и запускаем arch-1.sh
wget -O - https://raw.githubusercontent.com/jonathanblade/arch/main/arch-1.sh | sh
```
При разметке диска создаём две партиции:
1. EFI (512MB)
2. Linux Filesystem (всё оставшееся место)
