# Helper Files for PythonAnywhere Deployment

Saya telah membuat beberapa file tambahan untuk membantu proses deployment Anda di PythonAnywhere:

### 1. `pa_wsgi_config.py`
File ini berisi template konfigurasi WSGI. 
**Cara pakai:** 
- Buka tab **Web** di PythonAnywhere.
- Klik link **WSGI configuration file**.
- Hapus semua isinya dan tempel (paste) isi dari file `pa_wsgi_config.py` ini.
- Jangan lupa sesuaikan `username_anda` dan `nama_project` di dalam file tersebut.

### 2. `pa_setup.sh`
Script bash untuk mengotomatisasi perintah Django yang sering digunakan.
**Cara pakai:**
- Buka **Bash Console** di PythonAnywhere.
- Jalankan perintah: `bash pa_setup.sh`
- Script ini akan otomatis menjalankan `migrate` dan `collectstatic`.

### 3. `.pythonanywhere_ignore`
File ini digunakan jika Anda menggunakan PythonAnywhere CLI tool (`pa_uwsgi_config` dll) untuk mengabaikan file yang tidak diperlukan (seperti `.git`, `node_modules`, dll).

### 4. `requirements.txt` (Sudah ada)
Pastikan file ini berisi semua library yang Anda gunakan. Saat ini berisi:
- Django
- pytest
- streamlit
- djangorestframework

---
**Langkah Cepat:**
1. Upload file ke PythonAnywhere.
2. Buat Virtualenv dan install requirements: `pip install -r requirements.txt`.
3. Update WSGI config di tab Web menggunakan isi `pa_wsgi_config.py`.
4. Jalankan `bash pa_setup.sh` di console.
5. Reload Web App.
