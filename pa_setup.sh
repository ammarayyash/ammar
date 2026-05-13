#!/bin/bash

# Script ini digunakan untuk mempermudah setup awal atau update di PythonAnywhere
# Jalankan dengan: bash pa_setup.sh

echo "--- Memulai proses update/setup di PythonAnywhere ---"

# 1. Melakukan migrasi database
echo "1. Menjalankan migrasi database..."
python manage.py migrate

# 2. Mengumpulkan file statis
echo "2. Mengumpulkan file statis (collectstatic)..."
python manage.py collectstatic --noinput

echo "--- Proses Selesai! ---"
echo "Jangan lupa untuk klik tombol 'Reload' di tab Web PythonAnywhere."
