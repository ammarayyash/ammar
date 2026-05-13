# PythonAnywhere Deployment Guide – LMS Django Project

> **Important:** Ganti semua placeholder `USERNAME` dengan **username PythonAnywhere** Anda sebelum meng‑upload file.

---

## 1️⃣ Persiapan di PythonAnywhere

1. **Buat akun** (Jika belum): https://www.pythonanywhere.com/ (paket *Beginner* sudah cukup).
2. Login, kemudian buka **Consoles** → **Bash** (tab *Other*).

---

## 2️⃣ Clone repository Anda ke PythonAnywhere

```bash
# Masuk ke home directory
cd ~
# Clone repo (ganti URL jika private, gunakan HTTPS atau SSH)
git clone https://github.com/ammarayyash/ammar.git
# Masuk ke folder project
cd ammar
```

> **Catatan:** Pastikan folder hasil clone berisi `manage.py`, `requirements.txt`, dan folder `lms_project`.

---

## 3️⃣ Buat virtual environment (PEMATI KESESUAIAN PYTHON)

```bash
# Menggunakan Python 3.10 (versi yang kami gunakan dalam requirements)
mkvirtualenv --python=/usr/bin/python3.10 myvenv
```

Jika `mkvirtualenv` tidak tersedia, gunakan alternatif:
```bash
python3.10 -m venv ~/.virtualenvs/myvenv
source ~/.virtualenvs/myvenv/bin/activate
```

---

## 4️⃣ Install dependensi

```bash
pip install -r requirements.txt
```

> **Safety tip:** Pastikan `requirements.txt` hanya berisi paket yang diperlukan (Django, djangorestframework, Pillow). File `.pythonanywhere_ignore` sudah ada untuk mengecualikan folder‑folder tidak penting.

---

## 5️⃣ Konfigurasi `settings.py`

1. Buka tab **Files**, navigasikan ke:
```
/home/USERNAME/ammar/lms_project/settings.py
```
2. Ubah **ALLOWED_HOSTS** menjadi domain PythonAnywhere Anda:
```python
ALLOWED_HOSTS = ['USERNAME.pythonanywhere.com']
```
3. **(Opsional tapi disarankan)** ubah `DEBUG = False` untuk produksi. Simpan file.

---

## 6️⃣ Migrasi database & kumpulkan static files

Jalankan perintah berikut di *Bash console* (virtualenv harus aktif):
```bash
# Pastikan berada di root project
cd ~/ammar
python manage.py migrate
python manage.py collectstatic --noinput
```

Jika Anda belum memiliki superuser untuk admin, buat dengan:
```bash
python manage.py createsuperuser
```

---

## 7️⃣ Buat **Web app** di PythonAnywhere

1. Buka tab **Web** → **Add a new web app**.
2. **Pilih “Manual configuration”** (JANGAN pilih Django otomatis!).
3. Pilih **Python 3.10** (atau versi yang sama dengan virtualenv Anda).
4. Klik **Next** sampai selesai.

---

## 8️⃣ Konfigurasi **Source code**, **Working directory**, **Virtualenv**

| Setting | Value (ganti USERNAME) |
|---------|------------------------|
| **Source code** | `/home/USERNAME/ammar` |
| **Working directory** | `/home/USERNAME/ammar` |
| **Virtualenv** | `/home/USERNAME/.virtualenvs/myvenv` |

---

## 9️⃣ Edit **WSGI configuration file**

1. Di tab **Web**, pada bagian **Code**, klik link **WSGI configuration file** (biasanya bernama `USERNAME_pythonanywhere_com_wsgi.py`).
2. **Hapus semua isinya** dan ganti dengan kode berikut (simpan):
```python
import os
import sys

# Path ke folder project (folder yang berisi manage.py)
project_path = '/home/USERNAME/ammar'
if project_path not in sys.path:
    sys.path.append(project_path)

# Tentukan settings module Django
os.environ['DJANGO_SETTINGS_MODULE'] = 'lms_project.settings'

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
```
3. **Simpan** dan kembali ke tab **Web**.

---

## 🔟 Tambahkan **Static & Media files** di tab **Web**

| URL | Directory |
|-----|-----------|
| `/static/` | `/home/USERNAME/ammar/staticfiles` |
| `/media/`  | `/home/USERNAME/ammar/media` |

Klik **Add** untuk masing‑masing baris, lalu **Save**.

---

## 1️⃣1️⃣ Reload web app

Scroll ke atas pada tab **Web** dan klik tombol **Reload USERNAME.pythonanywhere.com** (hijau besar). Tunggu beberapa detik, kemudian buka URL:
```
https://USERNAME.pythonanywhere.com
```
Jika semuanya benar, situs LMS Anda akan tampil.

---

## 📂 File tambahan (sudah ada di repo) – JANGAN HAPUS!

| File | Tujuan |
|------|--------|
| `.pythonanywhere_ignore` | Mengabaikan folder‑folder tidak perlu saat upload (`node_modules`, `dist`, `.git`, dsb.). |
| `pa_wsgi_config.py` | Template WSGI yang dapat Anda copy‑paste ke file WSGI di tab **Web** (gunakan sebagai referensi). |
| `pa_setup.sh` | Script bash untuk menjalankan `migrate` & `collectstatic` di PythonAnywhere (jalankan bila ada perubahan). |
| `PA_README.md` | Panduan singkat untuk deployment – serupa dengan yang di atas. |

---

## 🛡️ Tips agar tidak “rusak” lagi

1. **Version control:** Semua perubahan harus melalui *git*. Sebelum meng‑upload ke PythonAnywhere, lakukan `git push` ke remote, lalu di console jalankan `git pull`. Ini menjaga sinkronisasi kode.
2. **Gunakan file `.env.example`:** Simpan variabel sensitif (SECRET_KEY, DATABASE_URL, dsb.) di file `.env` yang **tidak** di‑upload (tambahkan ke `.gitignore`). Pada `settings.py` gunakan `python-dotenv` untuk memuatnya.
3. **Jangan pernah edit `settings.py` langsung di production**; buat file `production_settings.py` yang di‑import lewat `DJANGO_SETTINGS_MODULE` bila perlu.
4. **Static files:** Selalu jalankan `python manage.py collectstatic --noinput` setelah menambah CSS/JS atau mengubah `STATIC_ROOT`.
5. **Backup database:** `python manage.py dumpdata > backup.json` secara berkala; restore dengan `python manage.py loaddata backup.json` bila ada kerusakan.
6. **Log error:** Di tab **Web**, periksa **Error log** bila ada 500/502. Tambahkan `DEBUG = False` dan periksa log untuk mengetahui penyebab sebenarnya.

---

## ✅ Checklist akhir (centang setelah selesai)
- [ ] Buat akun PythonAnywhere & login
- [ ] Clone repo ke `/home/USERNAME/ammar`
- [ ] Buat virtualenv `myvenv`
- [ ] `pip install -r requirements.txt`
- [ ] Edit `ALLOWED_HOSTS` & (opsional) `DEBUG` di `settings.py`
- [ ] `python manage.py migrate`
- [ ] `python manage.py collectstatic --noinput`
- [ ] Buat Web app (Manual config, Python 3.10)
- [ ] Set Source, Working directory, Virtualenv
- [ ] Ganti isi WSGI file dengan template di atas
- [ ] Tambahkan static & media mapping
- [ ] Reload web app dan tes di browser

---

Jika Anda mengikuti langkah‑demi‑langkah di atas, project Django LMS akan berjalan lancar di PythonAnywhere, tanpa risiko merusak konfigurasi yang ada. Selamat mencoba! 🚀
