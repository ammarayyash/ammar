import os
import sys

# ============================================================
# WSGI Configuration untuk PythonAnywhere
# ============================================================
# INSTRUKSI:
# 1. Buka tab Web di PythonAnywhere
# 2. Klik link WSGI configuration file
# 3. Hapus semua isi file tersebut
# 4. Copy-paste SEMUA kode di bawah ini
# 5. Ganti 'USERNAME' dengan username PythonAnywhere Anda
# 6. Klik Save
# ============================================================

# Path ke folder project (folder yang berisi manage.py)
path = '/home/USERNAME/ammar'
if path not in sys.path:
    sys.path.append(path)

os.environ['DJANGO_SETTINGS_MODULE'] = 'lms_project.settings'

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
