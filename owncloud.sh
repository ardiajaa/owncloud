#!/bin/bash    

showMe(){
 echo "@@@@@@@@@@@@@@@@@@@@@@B?!JJ55#@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@G!^~J!?#@@@@@@@@@@@@@@@@@@@
@@@@@@@&#BBBBBB#&@@@5!7?777J@@@#BBB#BB##&@@@@@@@
@@@@&#BGGGBBPPPGG&@#7?!77!77#@GBPPPBBBGGBB&@@@@@
@&&#BGGGGGBBPPPBB&@YJ??J?J??G@BBGPPBBBGGGGB##&@@
@@#BBGGGGGGBGGG#B&#GGGGGGGGGG&##GGGBGGGGGGBB#@@@
@##BGGGGGGGGBBBB#&B55PPPPPP5G&#BBBBBGGGGGGGB##@@
@@&BGGGGGGGGBBBBBPYPB@@@@@#PYPBBBBBGGGGGGGGB#@@@
@@#BBGGGGGGGGG#BY5PPB@@@@@#PG5YB#BPGGGGGGGBB#@@@
@@&&BBGGGGGGGGGGYGPPB@&P#@#PPG55GGPGGGGGGGB##@@@
@@@&BBGGGGGBGBGBYGPPB@@#&@#PPG5PBBGBGGGGGGB&@@@@
@@@&#BBGGBGBBBB@YPPPB@@&@@#PPGY&#BBBBBGGGG##@@@@
@@@@#BBBBBBB##@@GYGPB@&P#@#PG5P@@##BBBBBBBB@@@@@
@@@&BBBBBB#&@&##&G5PB@@@@@#P5P&&##@&#B#BBBB&@@@@
@@@#BB#B##@@@#5PB&B5P&@@@&GYG&#PPG@@@&#B#B#B@@@@
@@#BB###@@@@@@BPPPGBG5PGP5PBBPPPG@@@@@@&B#B##@@@
@&####&@@@@&BPY5PP5PPBGPGGPP5PP5J5B&@@@@&#####@@
&###@@@@@@@&GJYJY555PYB?G55PP55JYY5#@@@@@@@&##&@
#&@@@@@@@@@@@@BGYJ5J5P5?YP5YYYJGB&@@@@@@@@@@@@#&
@@@@@@@@@@@@@@@@&@BG#BGBGG#GG&&@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
"
}

showMe    
echo ""
echo "$(tput setaf 6)╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║      ownCloud + DNS Server Auto Installer Debian 12       ║"
echo "║                    Created by Ardi Ajaa                    ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝$(tput sgr0)"
echo ""
echo "$(tput setaf 2)Thanks for using this script....."
sleep 2s
reset
sleep 1s

# Input domain configuration
echo "$(tput setaf 3)╔════════════════════════════════════════════════════════════╗"
echo "║              DNS Configuration Setup                       ║"
echo "╚════════════════════════════════════════════════════════════╝$(tput sgr0)"
echo ""
read -p "$(tput setaf 6)Enter your subdomain (e.g., peserta1): $(tput sgr0)" SUBDOMAIN
read -p "$(tput setaf 6)Enter your domain (e.g., tkj.id): $(tput sgr0)" DOMAIN
FULL_DOMAIN="${SUBDOMAIN}.${DOMAIN}"
SERVER_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "$(tput setaf 2)Configuration Summary:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Full Domain  : $FULL_DOMAIN"
echo "Server IP    : $SERVER_IP"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(tput sgr0)"
echo ""
read -p "$(tput setaf 3)Continue with this configuration? (y/n): $(tput sgr0)" CONFIRM

if [[ $CONFIRM != "y" && $CONFIRM != "Y" ]]; then
    echo "$(tput setaf 1)Installation cancelled.$(tput sgr0)"
    exit 1
fi

echo ""
echo "$(tput setaf 3)Starting installation in 3 seconds...$(tput sgr0)"
sleep 3s
reset

echo "$(tput setaf 6)╔════════════════════════════════════════════════════════════╗$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  $(tput setaf 2)[Step 1/10]$(tput sgr0) Updating package lists...                  $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)╚════════════════════════════════════════════════════════════╝$(tput sgr0)"
apt-get update

echo ""
echo "$(tput setaf 6)╔════════════════════════════════════════════════════════════╗$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  $(tput setaf 2)[Step 2/10]$(tput sgr0) Installing Apache2, MariaDB & BIND9...      $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)╚════════════════════════════════════════════════════════════╝$(tput sgr0)"
apt install apache2 mariadb-server bind9 bind9utils bind9-doc dnsutils -y

echo ""
echo "$(tput setaf 6)╔════════════════════════════════════════════════════════════╗$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  $(tput setaf 2)[Step 3/10]$(tput sgr0) Installing required dependencies...         $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)╚════════════════════════════════════════════════════════════╝$(tput sgr0)"
apt install curl gnupg2 software-properties-common apt-transport-https lsb-release ca-certificates -y

echo ""
echo "$(tput setaf 6)╔════════════════════════════════════════════════════════════╗$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  $(tput setaf 2)[Step 4/10]$(tput sgr0) Configuring BIND9 DNS Server...             $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)╚════════════════════════════════════════════════════════════╝$(tput sgr0)"

# Backup original files
cp /etc/bind/named.conf.options /etc/bind/named.conf.options.bak
cp /etc/bind/named.conf.local /etc/bind/named.conf.local.bak

# Configure named.conf.options
cat > /etc/bind/named.conf.options << 'EOL'
options {
    directory "/var/cache/bind";
    
    recursion yes;
    allow-recursion { any; };
    
    listen-on { any; };
    listen-on-v6 { any; };
    
    forwarders {
        8.8.8.8;
        8.8.4.4;
    };
    
    dnssec-validation auto;
    
    auth-nxdomain no;
};
EOL

# Configure named.conf.local
cat > /etc/bind/named.conf.local << EOL
zone "${DOMAIN}" {
    type master;
    file "/etc/bind/zones/db.${DOMAIN}";
};

zone "$(echo $SERVER_IP | awk -F. '{print $3"."$2"."$1}').in-addr.arpa" {
    type master;
    file "/etc/bind/zones/db.$(echo $SERVER_IP | awk -F. '{print $3"."$2"."$1}')";
};
EOL

# Create zones directory
mkdir -p /etc/bind/zones

# Create forward zone file
cat > /etc/bind/zones/db.${DOMAIN} << EOL
;
; BIND data file for ${DOMAIN}
;
\$TTL    604800
@       IN      SOA     ${FULL_DOMAIN}. admin.${DOMAIN}. (
                              3         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ${FULL_DOMAIN}.
@       IN      A       ${SERVER_IP}
${SUBDOMAIN}    IN      A       ${SERVER_IP}
www     IN      CNAME   ${SUBDOMAIN}
EOL

# Create reverse zone file
REVERSE_IP=$(echo $SERVER_IP | awk -F. '{print $4"."$3"."$2"."$1}')
REVERSE_ZONE=$(echo $SERVER_IP | awk -F. '{print $3"."$2"."$1}')

cat > /etc/bind/zones/db.${REVERSE_ZONE} << EOL
;
; BIND reverse data file
;
\$TTL    604800
@       IN      SOA     ${FULL_DOMAIN}. admin.${DOMAIN}. (
                              3         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ${FULL_DOMAIN}.
$(echo $SERVER_IP | awk -F. '{print $4}')      IN      PTR     ${FULL_DOMAIN}.
EOL

# Check BIND configuration
named-checkconf
named-checkzone ${DOMAIN} /etc/bind/zones/db.${DOMAIN}
named-checkzone ${REVERSE_ZONE}.in-addr.arpa /etc/bind/zones/db.${REVERSE_ZONE}

# Restart BIND9
systemctl restart bind9
systemctl enable bind9

echo ""
echo "$(tput setaf 6)╔════════════════════════════════════════════════════════════╗$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  $(tput setaf 2)[Step 5/10]$(tput sgr0) Adding Sury PHP repository...               $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)╚════════════════════════════════════════════════════════════╝$(tput sgr0)"
curl -sSL https://packages.sury.org/php/README.txt
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

apt update

echo ""
echo "$(tput setaf 6)╔════════════════════════════════════════════════════════════╗$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  $(tput setaf 2)[Step 6/10]$(tput sgr0) Installing PHP 7.4 and modules...           $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)╚════════════════════════════════════════════════════════════╝$(tput sgr0)"
apt install php7.4 libapache2-mod-php7.4 php7.4-{mysql,intl,curl,json,gd,xml,mbstring,zip,cli,common} php-pear -y

php7.4 -v

echo ""
echo "$(tput setaf 6)╔════════════════════════════════════════════════════════════╗$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  $(tput setaf 2)[Step 7/10]$(tput sgr0) Adding ownCloud repository...               $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)╚════════════════════════════════════════════════════════════╝$(tput sgr0)"
echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/server:/10.9.1/Debian_12/ /' > /etc/apt/sources.list.d/isv:ownCloud:server:10.list
curl -fsSL https://download.opensuse.org/repositories/isv:ownCloud:server:10.9.1/Debian_12/Release.key | gpg --dearmor > /etc/apt/trusted.gpg.d/isv_ownCloud_server_10.gpg

apt update
apt install owncloud-complete-files -y

echo ""
echo "$(tput setaf 6)╔════════════════════════════════════════════════════════════╗$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  $(tput setaf 2)[Step 8/10]$(tput sgr0) Configuring Apache for ownCloud...          $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)╚════════════════════════════════════════════════════════════╝$(tput sgr0)"
mkdir -p /var/www/owncloud

# Configure Apache for ownCloud with domain
cat > /etc/apache2/sites-available/owncloud.conf << EOL
<VirtualHost *:80>
    ServerName ${FULL_DOMAIN}
    ServerAlias www.${FULL_DOMAIN}
    
    DocumentRoot /var/www/owncloud
    
    <Directory /var/www/owncloud/>
        Options +FollowSymlinks
        AllowOverride All
        
        <IfModule mod_dav.c>
            Dav off
        </IfModule>
        
        SetEnv HOME /var/www/owncloud
        SetEnv HTTP_HOME /var/www/owncloud
    </Directory>
    
    ErrorLog \${APACHE_LOG_DIR}/owncloud-error.log
    CustomLog \${APACHE_LOG_DIR}/owncloud-access.log combined
</VirtualHost>
EOL

a2ensite owncloud.conf
a2dissite 000-default.conf
a2enmod rewrite mime unique_id headers env dir

apachectl -t

systemctl restart apache2

echo ""
echo "$(tput setaf 6)╔════════════════════════════════════════════════════════════╗$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  $(tput setaf 2)[Step 9/10]$(tput sgr0) Configuring Database...                     $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)╚════════════════════════════════════════════════════════════╝$(tput sgr0)"
mysql << eof
CREATE DATABASE IF NOT EXISTS ownclouddb;
GRANT ALL PRIVILEGES ON ownclouddb.* TO 'owncloud'@'localhost' IDENTIFIED BY '1234';
FLUSH PRIVILEGES;
EXIT;
eof

echo ""
echo "$(tput setaf 6)╔════════════════════════════════════════════════════════════╗$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  $(tput setaf 2)[Step 10/10]$(tput sgr0) Installing ownCloud...                     $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)╚════════════════════════════════════════════════════════════╝$(tput sgr0)"
cd /var/www/owncloud
sudo -u www-data php occ maintenance:install \
   --database "mysql" \
   --database-name "ownclouddb" \
   --database-user "owncloud" \
   --database-pass "1234" \
   --admin-user "admin" \
   --admin-pass "1234"

# Add trusted domain
sudo -u www-data php occ config:system:set trusted_domains 1 --value=${FULL_DOMAIN}
sudo -u www-data php occ config:system:set trusted_domains 2 --value=www.${FULL_DOMAIN}

chown -R www-data:www-data /var/www/owncloud

# Configure system DNS to use local BIND9
echo "nameserver 127.0.0.1" > /etc/resolv.conf.new
cat /etc/resolv.conf >> /etc/resolv.conf.new
mv /etc/resolv.conf.new /etc/resolv.conf

clear
echo ""
echo "$(tput setaf 2)╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║      ✓ ownCloud + DNS Server Installation Complete! ✓     ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝$(tput sgr0)"
echo ""
echo "$(tput setaf 6)╔════════════════════════════════════════════════════════════╗$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  $(tput setaf 3)DNS Server Information:$(tput sgr0)                                  $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  --------------------------------------------------------  $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  DNS Server   : $(tput setaf 2)${SERVER_IP}$(tput sgr0)                              $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  Domain       : $(tput setaf 2)${DOMAIN}$(tput sgr0)                                 $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  Full Domain  : $(tput setaf 2)${FULL_DOMAIN}$(tput sgr0)                            $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)╚════════════════════════════════════════════════════════════╝$(tput sgr0)"
echo ""
echo "$(tput setaf 6)╔════════════════════════════════════════════════════════════╗$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  $(tput setaf 3)ownCloud Access Information:$(tput sgr0)                            $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  --------------------------------------------------------  $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  URL          : $(tput setaf 2)http://${FULL_DOMAIN}$(tput sgr0)                     $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  Alternative  : $(tput setaf 2)http://${SERVER_IP}$(tput sgr0)                       $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  Username     : $(tput setaf 2)admin$(tput sgr0)                                     $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)║$(tput sgr0)  Password     : $(tput setaf 2)1234$(tput sgr0)                                      $(tput setaf 6)║$(tput sgr0)"
echo "$(tput setaf 6)╚════════════════════════════════════════════════════════════╝$(tput sgr0)"
echo ""
echo "$(tput setaf 3)╔════════════════════════════════════════════════════════════╗"
echo "║  How to use DNS on client machines:                       ║"
echo "║  --------------------------------------------------------  ║"
echo "║  1. Edit /etc/resolv.conf (Linux)                         ║"
echo "║     Add: nameserver ${SERVER_IP}                          "
echo "║                                                            ║"
echo "║  2. Windows: Network Adapter Settings                     ║"
echo "║     Set DNS to: ${SERVER_IP}                              "
echo "║                                                            ║"
echo "║  3. Test DNS with: nslookup ${FULL_DOMAIN}                "
echo "╚════════════════════════════════════════════════════════════╝$(tput sgr0)"
echo ""
echo "$(tput setaf 1)⚠ IMPORTANT SECURITY NOTES:"
echo "  • Change default password after first login!"
echo "  • Update DNS forwarders if needed in /etc/bind/named.conf.options"
echo "  • Configure firewall to allow ports 53 (DNS) and 80 (HTTP)$(tput sgr0)"
echo ""
echo "$(tput setaf 5)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(tput sgr0)"
echo "$(tput setaf 6)         Script created by Ardi Ajaa | Debian 12 Edition$(tput sgr0)"
echo "$(tput setaf 5)━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$(tput sgr0)"
echo ""

# Test DNS
echo "$(tput setaf 2)Testing DNS Configuration...$(tput sgr0)"
echo ""
nslookup ${FULL_DOMAIN} 127.0.0.1
echo ""