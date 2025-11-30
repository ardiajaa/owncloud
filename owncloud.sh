#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Unicode symbols
CHECK="✓"
CROSS="✗"
ARROW="➜"
STAR="★"
GEAR="⚙"

clear

# Banner function
show_banner() {
    echo -e "${CYAN}"
    cat << "EOF"
    ╔═══════════════════════════════════════════════════════════════╗
    ║                                                               ║
    ║     ██████╗ ██╗    ██╗███╗   ██╗ ██████╗██╗      ██████╗      ║
    ║    ██╔═══██╗██║    ██║████╗  ██║██╔════╝██║     ██╔═══██╗     ║
    ║    ██║   ██║██║ █╗ ██║██╔██╗ ██║██║     ██║     ██║   ██║     ║
    ║    ██║   ██║██║███╗██║██║╚██╗██║██║     ██║     ██║   ██║     ║
    ║    ╚██████╔╝╚███╔███╔╝██║ ╚████║╚██████╗███████╗╚██████╔╝     ║
    ║     ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝ ╚═════╝╚══════╝ ╚═════╝      ║
    ║                                                               ║
    ║              AUTO INSTALLER FOR DEBIAN 12                     ║
    ║                   Powered by Ardi Aja                         ║
    ║                                                               ║
    ╚═══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    echo -e "${YELLOW}                    ${STAR} Powered by: ${BOLD}Ardi Aja${NC} ${STAR}${NC}"
    echo -e "${MAGENTA}              GitHub: ${WHITE}https://github.com/ardiajaa/${NC}"
    echo -e "${CYAN}    ═══════════════════════════════════════════════════════════${NC}"
    echo ""
}

# Progress bar function
show_progress() {
    local current=$1
    local total=$2
    local width=50
    local percentage=$((current * 100 / total))
    local filled=$((width * current / total))
    local empty=$((width - filled))
    
    printf "\r${CYAN}["
    printf "%${filled}s" | tr ' ' '█'
    printf "%${empty}s" | tr ' ' '░'
    printf "] ${WHITE}%3d%%${NC}" $percentage
}

# Step header function
step_header() {
    local step=$1
    local total=$2
    local title=$3
    echo ""
    echo -e "${BLUE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC} ${GREEN}${GEAR} Step [$step/$total]${NC} ${WHITE}$title${NC}"
    echo -e "${BLUE}╚═══════════════════════════════════════════════════════════════╝${NC}"
}

# Success message function
success_msg() {
    echo -e "${GREEN}${CHECK}${NC} $1"
}

# Info message function
info_msg() {
    echo -e "${CYAN}${ARROW}${NC} $1"
}

# Warning message function
warn_msg() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Error message function
error_msg() {
    echo -e "${RED}${CROSS}${NC} $1"
}

# Input box function
input_box() {
    local prompt=$1
    local default=$2
    echo -e "${CYAN}┌─────────────────────────────────────────────────────────────┐${NC}"
    if [ -n "$default" ]; then
        echo -e "${CYAN}│${NC} ${YELLOW}${prompt}${NC} ${WHITE}[default: $default]${NC}"
    else
        echo -e "${CYAN}│${NC} ${YELLOW}${prompt}${NC}"
    fi
    echo -e "${CYAN}└─────────────────────────────────────────────────────────────┘${NC}"
    echo -ne "${GREEN}${ARROW} ${NC}"
}

# Show banner
show_banner

sleep 1

# ===============================================
# AUTO DETECT SERVER IP
# ===============================================
step_header 1 8 "Deteksi IP Server"
AUTO_IP=$(hostname -I | awk '{print $1}')

echo ""
info_msg "IP terdeteksi otomatis: ${WHITE}$AUTO_IP${NC}"
echo ""
input_box "Gunakan IP ini? (y/n)"
read -p "" USEAUTO

if [ "$USEAUTO" = "y" ] || [ "$USEAUTO" = "Y" ]; then
    SERVER_IP=$AUTO_IP
    success_msg "Menggunakan IP: ${WHITE}$SERVER_IP${NC}"
else
    echo ""
    input_box "Masukkan IP server manual"
    read -p "" SERVER_IP
    success_msg "IP server diset: ${WHITE}$SERVER_IP${NC}"
fi

# ===============================================
# Input Domain
# ===============================================
step_header 2 8 "Konfigurasi Domain"
echo ""
input_box "Masukkan domain (contoh: ardianto.my.id)"
read -p "" DOMAIN
success_msg "Domain: ${WHITE}$DOMAIN${NC}"

# ===============================================
# Input Database Name
# ===============================================
step_header 3 8 "Konfigurasi Database"
echo ""
input_box "Masukkan nama database OwnCloud" "ownclouddb"
read -p "" DBNAME
DBNAME=${DBNAME:-ownclouddb}
success_msg "Nama database: ${WHITE}$DBNAME${NC}"

# ===============================================
# Input MySQL root Password
# ===============================================
echo ""
input_box "Masukkan password ROOT database"
read -s -p "" DBPASS
echo ""
success_msg "Password database telah diset"

# ===============================================
# Configuration Summary
# ===============================================
echo ""
echo -e "${MAGENTA}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║${NC}              ${BOLD}${WHITE}RINGKASAN KONFIGURASI${NC}                         ${MAGENTA}║${NC}"
echo -e "${MAGENTA}╠═══════════════════════════════════════════════════════════════╣${NC}"
echo -e "${MAGENTA}║${NC} ${CYAN}Domain          :${NC} ${WHITE}$DOMAIN${NC}"
echo -e "${MAGENTA}║${NC} ${CYAN}Server IP       :${NC} ${WHITE}$SERVER_IP${NC}"
echo -e "${MAGENTA}║${NC} ${CYAN}Database Name   :${NC} ${WHITE}$DBNAME${NC}"
echo -e "${MAGENTA}║${NC} ${CYAN}Database User   :${NC} ${WHITE}root${NC}"
echo -e "${MAGENTA}║${NC} ${CYAN}Database Pass   :${NC} ${WHITE}••••••••${NC} ${GREEN}(Hidden)${NC}"
echo -e "${MAGENTA}╚═══════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}${ARROW} Instalasi akan dimulai dalam 3 detik...${NC}"
sleep 3

# ===============================================
# Update Sistem
# ===============================================
step_header 4 8 "Update & Install Dependencies"
echo ""
info_msg "Memperbarui sistem..."
apt update > /dev/null 2>&1 &
PID=$!
while kill -0 $PID 2>/dev/null; do
    show_progress 1 5
    sleep 0.5
done
wait $PID
echo ""
success_msg "Sistem berhasil diperbarui"

info_msg "Menginstall dependencies..."
apt install curl gnupg2 lsb-release ca-certificates software-properties-common -y > /dev/null 2>&1
success_msg "Dependencies terinstall"

# ===============================================
# INSTALL PHP 7.4 DARI SURY
# ===============================================
step_header 5 8 "Install PHP 7.4 & Apache"
echo ""
info_msg "Menambahkan repository Sury untuk PHP 7.4..."

curl -fsSL https://packages.sury.org/php/apt.gpg \
| gpg --dearmor -o /etc/apt/trusted.gpg.d/sury.gpg 2>/dev/null

echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" \
> /etc/apt/sources.list.d/sury-php.list

apt update > /dev/null 2>&1
success_msg "Repository Sury ditambahkan"

info_msg "Menginstall Apache & MariaDB..."
apt install apache2 mariadb-server -y > /dev/null 2>&1
success_msg "Apache & MariaDB terinstall"

info_msg "Menginstall PHP 7.4 dan modul-modulnya..."
apt install php7.4 php7.4-{cli,common,mysql,xml,gd,curl,zip,mbstring,intl,bz2,ldap,imap} \
           libapache2-mod-php7.4 -y > /dev/null 2>&1

# Disable PHP 8.x
a2dismod php8.2 2>/dev/null
a2dismod php8.1 2>/dev/null
a2dismod php8.0 2>/dev/null

a2enmod php7.4 > /dev/null 2>&1
update-alternatives --set php /usr/bin/php7.4 > /dev/null 2>&1

systemctl restart apache2
success_msg "PHP 7.4 berhasil diinstall dan dikonfigurasi"

# ===============================================
# REPO OWNCLOUD
# ===============================================
step_header 6 8 "Install OwnCloud"
echo ""
info_msg "Menambahkan repository OwnCloud..."

echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/server:/10/Debian_12/ /' \
> /etc/apt/sources.list.d/owncloud.list

curl -fsSL https://download.opensuse.org/repositories/isv:ownCloud:server:10/Debian_12/Release.key \
| gpg --dearmor > /etc/apt/trusted.gpg.d/owncloud.gpg 2>/dev/null

apt update > /dev/null 2>&1
success_msg "Repository OwnCloud ditambahkan"

info_msg "Menginstall OwnCloud..."
apt install owncloud-complete-files -y > /dev/null 2>&1
mkdir -p /var/www/owncloud
success_msg "OwnCloud berhasil terinstall"

# ===============================================
# Apache VirtualHost + ServerAlias
# ===============================================
step_header 7 8 "Konfigurasi Apache VirtualHost"
echo ""
info_msg "Membuat VirtualHost untuk $DOMAIN..."

cat > /etc/apache2/sites-available/$DOMAIN.conf << EOF
<VirtualHost *:80>
    ServerName $DOMAIN
    ServerAlias www.$DOMAIN
    ServerAlias $SERVER_IP

    DocumentRoot /var/www/owncloud/

    <Directory /var/www/owncloud/>
        AllowOverride All
        Options +FollowSymlinks

        <IfModule mod_dav.c>
            Dav off
        </IfModule>

        SetEnv HOME /var/www/owncloud
        SetEnv HTTP_HOME /var/www/owncloud
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/owncloud_error.log
    CustomLog \${APACHE_LOG_DIR}/owncloud_access.log combined
</VirtualHost>
EOF

a2dissite 000-default.conf > /dev/null 2>&1
a2ensite $DOMAIN.conf > /dev/null 2>&1
a2enmod rewrite mime unique_id > /dev/null 2>&1
systemctl reload apache2
success_msg "VirtualHost berhasil dikonfigurasi"

# ===============================================
# Database OwnCloud
# ===============================================
step_header 8 8 "Setup Database"
echo ""
info_msg "Membuat database OwnCloud..."

mysql --user=root -p$DBPASS << EOF 2>/dev/null
CREATE DATABASE $DBNAME;
GRANT ALL PRIVILEGES ON $DBNAME.* TO 'root'@'localhost' IDENTIFIED BY '$DBPASS';
FLUSH PRIVILEGES;
EOF

success_msg "Database ${WHITE}$DBNAME${NC} berhasil dibuat"

# ===============================================
# END OUTPUT
# ===============================================
clear
echo ""
echo -e "${GREEN}"
cat << "EOF"
    ╔═══════════════════════════════════════════════════════════════╗
    ║                                                               ║
    ║    ✓✓✓  INSTALLATION COMPLETED SUCCESSFULLY!  ✓✓✓           ║
    ║                                                               ║
    ╚═══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}                  ${BOLD}${WHITE}INFORMASI AKSES${NC}                          ${CYAN}║${NC}"
echo -e "${CYAN}╠═══════════════════════════════════════════════════════════════╣${NC}"
echo -e "${CYAN}║${NC} ${YELLOW}Akses via IP:${NC}      ${GREEN}http://$SERVER_IP${NC}"
echo -e "${CYAN}║${NC} ${YELLOW}Akses via Domain:${NC}  ${GREEN}http://$DOMAIN${NC}"
echo -e "${CYAN}║${NC} ${YELLOW}Akses via WWW:${NC}     ${GREEN}http://www.$DOMAIN${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════╝${NC}"

echo ""
echo -e "${MAGENTA}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║${NC}                ${BOLD}${WHITE}DATABASE INFORMATION${NC}                     ${MAGENTA}║${NC}"
echo -e "${MAGENTA}╠═══════════════════════════════════════════════════════════════╣${NC}"
echo -e "${MAGENTA}║${NC} ${CYAN}Database Name:${NC}     ${WHITE}$DBNAME${NC}"
echo -e "${MAGENTA}║${NC} ${CYAN}Database User:${NC}     ${WHITE}root${NC}"
echo -e "${MAGENTA}║${NC} ${CYAN}Database Password:${NC} ${WHITE}$DBPASS${NC}"
echo -e "${MAGENTA}╚═══════════════════════════════════════════════════════════════╝${NC}"

echo ""
echo -e "${YELLOW}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${YELLOW}║${NC}  ${BOLD}${WHITE}LANGKAH SELANJUTNYA:${NC}                                      ${YELLOW}║${NC}"
echo -e "${YELLOW}╠═══════════════════════════════════════════════════════════════╣${NC}"
echo -e "${YELLOW}║${NC}  ${GREEN}1.${NC} Buka browser dan akses salah satu URL di atas          ${YELLOW}║${NC}"
echo -e "${YELLOW}║${NC}  ${GREEN}2.${NC} Buat akun admin di halaman setup OwnCloud              ${YELLOW}║${NC}"
echo -e "${YELLOW}║${NC}  ${GREEN}3.${NC} Masukkan informasi database di atas saat diminta      ${YELLOW}║${NC}"
echo -e "${YELLOW}║${NC}  ${GREEN}4.${NC} Klik 'Finish setup' untuk menyelesaikan               ${YELLOW}║${NC}"
echo -e "${YELLOW}╚═══════════════════════════════════════════════════════════════╝${NC}"

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}            ${STAR} Script Created by: ${BOLD}${CYAN}Ardi Aja${NC} ${WHITE}${STAR}${NC}"
echo -e "${WHITE}            GitHub: ${MAGENTA}https://github.com/ardiajaa/${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${GREEN}${CHECK} Terima kasih telah menggunakan script ini! ${CHECK}${NC}"
echo ""