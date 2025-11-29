# 🚀 ownCloud + BIND9 DNS Auto Installer

Script otomatis untuk instalasi ownCloud dengan DNS Server (BIND9) di Debian 12.

## 📋 Fitur

- ✅ Instalasi ownCloud 10.9.1
- ✅ Konfigurasi DNS Server (BIND9)
- ✅ Setup Apache2 & MariaDB
- ✅ PHP 7.4 dengan semua modul yang diperlukan
- ✅ Virtual Host dengan custom domain
- ✅ Tampilan instalasi yang menarik dengan progress bar
- ✅ Otomatis setup trusted domains

## 🖥️ Requirements

- Debian 12 (Bookworm)
- Akses root / sudo
- Koneksi internet
- Minimal RAM 2GB
- Minimal Storage 20GB

## 📦 Instalasi

### 1. Clone Repository

```bash
git clone https://github.com/ardiajaa/owncloud.git
cd owncloud
```

### 2. Berikan Permission

```bash
chmod +x owncloud.bash
```

### 3. Jalankan Script

```bash
sudo ./owncloud.bash
```

### 4. Ikuti Instruksi

Script akan meminta input:
- **Subdomain**: Contoh `peserta1`
- **Domain**: Contoh `tkj.id`

Hasil: `peserta1.tkj.id` akan mengarah ke server ownCloud Anda.

## 🌐 Akses ownCloud

Setelah instalasi selesai:

**Via Domain:**
```
http://peserta1.tkj.id
```

**Via IP:**
```
http://IP_SERVER
```

**Login Default:**
- Username: `admin`
- Password: `1234`

> ⚠️ **PENTING**: Segera ganti password default setelah login pertama!

## 🔧 Konfigurasi DNS Client

### Linux
```bash
echo "nameserver IP_SERVER" | sudo tee /etc/resolv.conf
```

### Windows
1. Buka **Network and Sharing Center**
2. Klik **Change adapter settings**
3. Klik kanan adapter → **Properties**
4. Pilih **Internet Protocol Version 4 (TCP/IPv4)**
5. Pilih **Use the following DNS server addresses**
6. Masukkan IP server Anda
7. Klik **OK**

### Test DNS
```bash
nslookup peserta1.tkj.id
```

## 📁 Struktur Instalasi

```
/var/www/owncloud/          # Directory ownCloud
/etc/bind/zones/            # DNS Zone files
/etc/apache2/sites-available/owncloud.conf    # Apache config
```

## 🔐 Keamanan

- Ganti password default `admin` dan `root`
- Konfigurasi firewall untuk port 53 (DNS) dan 80 (HTTP)
- Pertimbangkan SSL/TLS untuk production

```bash
# Allow DNS
sudo ufw allow 53/tcp
sudo ufw allow 53/udp

# Allow HTTP
sudo ufw allow 80/tcp
```

## 🛠️ Troubleshooting

### DNS Tidak Berfungsi

```bash
# Cek status BIND9
sudo systemctl status bind9

# Restart BIND9
sudo systemctl restart bind9

# Cek konfigurasi
sudo named-checkconf
```

### ownCloud Error

```bash
# Cek log Apache
sudo tail -f /var/log/apache2/owncloud-error.log

# Restart Apache
sudo systemctl restart apache2
```

### Database Error

```bash
# Login ke MariaDB
sudo mysql -u root

# Cek database
SHOW DATABASES;
USE ownclouddb;
```

## 📝 Catatan

- Script ini menggunakan password default `1234` untuk semua service
- Cocok untuk testing dan development
- Untuk production, ganti semua password dan tambahkan SSL

## 📄 Lisensi

Distributed under the MIT License. See `LICENSE` for more information.

## 👨‍💻 Author

**Ardi Ajaa**

- GitHub: [@ardiajaa](https://github.com/ardiajaa)

## ⭐ Support

Jika script ini membantu, jangan lupa kasih ⭐ di repository ini!

---

Made with ❤️ by Ardi Ajaa