import os
import sys

# Tentukan path ke direktori project Anda
# Ganti 'username_anda' dengan username PythonAnywhere Anda
# Ganti 'nama_project' dengan nama folder project Anda di PythonAnywhere
path = '/home/username_anda/nama_project'
if path not in sys.path:
    sys.path.append(path)

# Beritahu Django di mana letak settings.py
# Sesuaikan 'lms_project.settings' jika nama folder project utama Anda berbeda
os.environ['DJANGO_SETTINGS_MODULE'] = 'lms_project.settings'

# Import WSGI application dari Django
from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
