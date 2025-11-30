# OwnCloud Auto Installer for Debian 12

Script bash otomatis untuk instalasi **ownCloud** di Debian 12. Simple dan mudah digunakan!

---

## Cara Kerja

1. **Pastikan Anda sudah masuk sebagai user root.**

2. **Install Git terlebih dahulu (jika belum terpasang):**
   ```bash
   apt install git -y
   ```

3. **Clone repository ini:**
   ```bash
   git clone https://github.com/ardiajaa/owncloud.git
   cd owncloud
   ```

4. **Jalankan script-nya:**
   ```bash
   chmod +x owncloud.sh
   ./owncloud.sh
   ```

5. **Ikuti instruksi pada layar.**
   - Masukkan IP server, domain, dan detail database sesuai prompt.
   - Script akan otomatis menginstall PHP 7.4, Apache2, MariaDB, dan OwnCloud lengkap beserta konfigurasinya.

6. **Akses ownCloud Anda via browser menggunakan IP Server**

## Powered by Ardi Ajaa  
GitHub: [https://github.com/ardiajaa](https://github.com/ardiajaa)
