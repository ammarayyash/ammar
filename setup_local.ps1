# PowerShell script to set up and run the Django project locally
# Save as setup_local.ps1 and run it from PowerShell

# 1. Create virtual environment (if not exists)
if (-Not (Test-Path -Path ".venv")) {
    Write-Host "Creating virtual environment..."
    python -m venv .venv
}

# 2. Activate virtual environment
Write-Host "Activating virtual environment..."
& ".venv\Scripts\Activate.ps1"

# 3. Upgrade pip (optional but recommended)
Write-Host "Upgrading pip..."
python -m pip install --upgrade pip

# 4. Install required packages
Write-Host "Installing requirements..."
python -m pip install -r requirements.txt

# 5. Apply migrations
Write-Host "Running migrations..."
python manage.py migrate

# 6. (Optional) Create superuser if none exists – you can comment out if not needed
# Write-Host "Creating superuser (you will be prompted)"
# python manage.py createsuperuser

# 7. Start development server
Write-Host "Starting Django development server..."
python manage.py runserver
