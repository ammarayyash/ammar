#!/bin/bash
# -------------------------------------------------
# pa_setup.sh – Setup & Deploy di PythonAnywhere
# -------------------------------------------------
# 1. Pastikan virtualenv sudah dibuat (myvenv)
VENV_DIR="$HOME/.virtualenvs/myvenv"

if [ ! -d "$VENV_DIR" ]; then
    echo "🔧 Membuat virtualenv di $VENV_DIR ..."
    # gunakan Python 3.10 yang ter‑install di PythonAnywhere
    mkvirtualenv --python=/usr/bin/python3.10 myvenv
else
    echo "✅ Virtualenv $VENV_DIR sudah ada."
fi

# 2. Aktifkan virtualenv
echo "⚡ Mengaktifkan virtualenv ..."
source "$VENV_DIR/bin/activate"

# 3. Upgrade pip (opsional tapi disarankan)
echo "⬆️ Upgrade pip ..."
pip install --upgrade pip

# 4. Install dependensi
echo "📦 Install requirements.txt ..."
pip install -r requirements.txt

# 5. Migrasi database
echo "🗄️ Jalankan migrasi database ..."
python manage.py migrate

# 6. (Opsional) Buat superuser – Anda akan diminta mengisi data
# echo "👤 Membuat superuser..."
# python manage.py createsuperuser

# 7. Kumpulkan static files
echo "🧹 Collect static files ..."
python manage.py collectstatic --noinput

# 8. Selesai – beri tahu user untuk reload web app
echo "✅ Setup selesai! Sekarang kembali ke tab **Web** dan klik **Reload**."
