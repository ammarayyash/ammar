# 🚀 Panduan Lengkap Deploy Django ke PythonAnywhere

Panduan ini menjelaskan langkah demi langkah cara mendeploy project **LMS Django** ke PythonAnywhere dari awal.

> **Info:** GitHub Repo: `https://github.com/ammarayyash/ammar.git`
> Ganti `USERNAME` di bawah ini dengan username PythonAnywhere Anda.

---

## Langkah 1: Daftar / Login ke PythonAnywhere

1. Buka [https://www.pythonanywhere.com](https://www.pythonanywhere.com)
2. Klik **Pricing & signup** → pilih **Beginner (Free)** → daftar akun
3. Login ke dashboard PythonAnywhere

---

## Langkah 2: Clone Project dari GitHub

1. Buka tab **Consoles**
2. Klik **Bash** (di bagian "Other") untuk membuka terminal baru
3. Jalankan perintah berikut di Bash console:

```bash
git clone https://github.com/ammarayyash/ammar.git
```

> Ini akan membuat folder `ammar` di `/home/USERNAME/ammar`

---

## Langkah 3: Buat Virtual Environment

Masih di Bash console yang sama, jalankan:

```bash
mkvirtualenv --python=/usr/bin/python3.10 myvenv
```

> Jika `mkvirtualenv` tidak tersedia, gunakan:
> ```bash
> python3.10 -m venv /home/USERNAME/.virtualenvs/myvenv
> source /home/USERNAME/.virtualenvs/myvenv/bin/activate
> ```

---

## Langkah 4: Install Requirements

```bash
cd ~/ammar
pip install -r requirements.txt
```

File `requirements.txt` berisi:
```
Django>=3.2,<7
djangorestframework
Pillow
```

---

## Langkah 5: Edit settings.py

Buka tab **Files** di PythonAnywhere, navigasi ke:
```
/home/USERNAME/ammar/lms_project/settings.py
```

### 5a. Ubah ALLOWED_HOSTS (baris 28)

Dari:
```python
ALLOWED_HOSTS = ['*']
```

Menjadi:
```python
ALLOWED_HOSTS = ['USERNAME.pythonanywhere.com']
```

> Ganti `USERNAME` dengan username PythonAnywhere Anda yang sebenarnya.

### 5b. (Opsional) Matikan DEBUG untuk production

Dari:
```python
DEBUG = True
```

Menjadi:
```python
DEBUG = False
```

> **Catatan:** Biarkan `DEBUG = True` dulu saat pertama kali deploy agar mudah melihat error. Setelah yakin semua berjalan, baru ubah ke `False`.

### 5c. Pastikan STATIC_ROOT sudah ada (baris 121)

Seharusnya sudah ada baris ini:
```python
STATIC_ROOT = BASE_DIR / 'staticfiles'
```

Jika belum ada, tambahkan di bawah `STATIC_URL = 'static/'`.

---

## Langkah 6: Migrasi Database & Collectstatic

Kembali ke **Bash console**, pastikan virtualenv aktif:

```bash
workon myvenv
cd ~/ammar
```

Jalankan migrasi dan kumpulkan file statis:

```bash
python manage.py migrate
python manage.py collectstatic --noinput
```

### 6a. (Opsional) Buat Superuser

Jika ingin mengakses halaman admin Django:

```bash
python manage.py createsuperuser
```

Ikuti instruksi untuk mengisi username, email, dan password.

---

## Langkah 7: Buat Web App

1. Buka tab **Web** di dashboard PythonAnywhere
2. Klik **Add a new web app**
3. Klik **Next**
4. **PENTING:** Pilih **Manual configuration** (JANGAN pilih "Django")
5. Pilih **Python 3.10** (harus sama dengan versi virtualenv)
6. Klik **Next** sampai selesai

---

## Langkah 8: Konfigurasi Web App

Masih di tab **Web**, isi bagian-bagian berikut:

### 8a. Source Code

```
/home/USERNAME/ammar
```

### 8b. Working Directory

```
/home/USERNAME/ammar
```

### 8c. Virtualenv

Di bagian **Virtualenv**, masukkan:

```
/home/USERNAME/.virtualenvs/myvenv
```

---

## Langkah 9: Edit WSGI Configuration File

1. Di tab **Web**, pada bagian **Code**, klik link file WSGI:
   `USERNAME_pythonanywhere_com_wsgi.py`

2. **Hapus semua isinya**, lalu ganti dengan kode berikut:

```python
import os
import sys

# Path ke folder project (folder yang berisi manage.py)
path = '/home/USERNAME/ammar'
if path not in sys.path:
    sys.path.append(path)

os.environ['DJANGO_SETTINGS_MODULE'] = 'lms_project.settings'

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
```

> ⚠️ **Ganti `USERNAME` dengan username PythonAnywhere Anda!**

3. Klik **Save**

---

## Langkah 10: Konfigurasi Static Files & Media

Masih di tab **Web**, scroll ke bagian **Static files**.

Klik **Enter URL** dan **Enter path** untuk menambahkan:

| URL | Directory |
|-----|-----------|
| `/static/` | `/home/USERNAME/ammar/staticfiles` |
| `/media/` | `/home/USERNAME/ammar/media` |

---

## Langkah 11: Reload & Test

1. Scroll ke atas di tab **Web**
2. Klik tombol hijau besar **🔄 Reload USERNAME.pythonanywhere.com**
3. Buka browser dan akses: `https://USERNAME.pythonanywhere.com`

---

## 🔧 Troubleshooting

### Error "ModuleNotFoundError"
- Pastikan virtualenv path sudah benar di tab Web
- Coba jalankan `workon myvenv && pip install -r requirements.txt` lagi

### Error "DisallowedHost"
- Pastikan `ALLOWED_HOSTS` di `settings.py` berisi domain PythonAnywhere Anda

### Halaman putih / 500 Error
- Set `DEBUG = True` sementara untuk melihat error detail
- Cek **Error log** di tab Web (klik link error log)

### Static files tidak muncul (CSS/JS hilang)
- Pastikan sudah menjalankan `python manage.py collectstatic --noinput`
- Pastikan path static files di tab Web sudah benar: `/home/USERNAME/ammar/staticfiles`

### Gambar / upload tidak muncul
- Pastikan path media di tab Web sudah benar: `/home/USERNAME/ammar/media`

---

## 📋 Ringkasan Struktur File di PythonAnywhere

```
/home/USERNAME/
├── ammar/                      ← Project root (hasil git clone)
│   ├── manage.py
│   ├── requirements.txt
│   ├── db.sqlite3
│   ├── lms_project/
│   │   ├── __init__.py
│   │   ├── settings.py         ← Edit ALLOWED_HOSTS di sini
│   │   ├── urls.py
│   │   └── wsgi.py
│   ├── dashboard/
│   │   ├── models.py
│   │   ├── views.py
│   │   ├── urls.py
│   │   ├── static/
│   │   └── templates/
│   ├── media/                  ← Upload files
│   └── staticfiles/            ← Hasil collectstatic
└── .virtualenvs/
    └── myvenv/                 ← Virtual environment
```

---

## 🔄 Cara Update Setelah Push ke GitHub

Jika Anda melakukan perubahan di lokal dan push ke GitHub, jalankan di Bash console PythonAnywhere:

```bash
cd ~/ammar
git pull origin main
workon myvenv
pip install -r requirements.txt
python manage.py migrate
python manage.py collectstatic --noinput
```

Lalu klik **Reload** di tab Web.
