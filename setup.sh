#!/bin/bash

echo "🚀 MAHIR HOISTING Installation Script"
echo "================================"

# Check Python version
if command -v python3 &>/dev/null; then
    python_version=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
    required_version="3.8"
    
    if [ "$(printf '%s\n' "$required_version" "$python_version" | sort -V | head -n1)" != "$required_version" ]; then 
        echo "❌ Python $required_version or higher is required. Found: $python_version"
        exit 1
    fi
    echo "✅ Python $python_version found"
else
    echo "❌ Python 3 not found. Please install Python 3.8+"
    exit 1
fi

# Create virtual environment
echo "📦 Creating virtual environment..."
python3 -m venv venv
if [ $? -ne 0 ]; then
    echo "❌ Failed to create virtual environment"
    exit 1
fi

# Activate virtual environment
source venv/bin/activate

# Upgrade pip
echo "📥 Upgrading pip..."
pip install --upgrade pip

# Install requirements
echo "📥 Installing dependencies..."
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
    if [ $? -ne 0 ]; then
        echo "❌ Failed to install requirements"
        exit 1
    fi
else
    echo "⚠️ requirements.txt not found!"
    # Install default packages
    pip install Flask Flask-SocketIO werkzeug psutil eventlet
fi

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p storage/instances
mkdir -p static/uploads
mkdir -p templates/web

# Set permissions
echo "🔐 Setting permissions..."
chmod -R 755 storage 2>/dev/null || true
chmod -R 755 static 2>/dev/null || true

# Create default profile picture if not exists
if [ ! -f "static/uploads/default.png" ]; then
    echo "🖼️ Creating default profile picture..."
    # Create a simple 1x1 pixel PNG (base64 encoded)
    echo "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==" | base64 -d > static/uploads/default.png
fi

# Create .env file if not exists
if [ ! -f ".env" ]; then
    echo "📝 Creating .env file..."
    cat > .env << EOF
FLASK_ENV=development
SECRET_KEY=nehost_ultra_pro_max_99_$(openssl rand -hex 16)
ADMIN_USERNAME=MAHIRJOD
ADMIN_PASSWORD=MAHIRJOD
EOF
fi

# Create __init__.py for templates if needed
touch templates/__init__.py 2>/dev/null || true
touch templates/web/__init__.py 2>/dev/null || true

echo ""
echo "✅ Setup complete successfully!"
echo ""
echo "📋 Next steps:"
echo "  1. Activate environment: source venv/bin/activate"
echo "  2. Start the server: python app.py"
echo ""
echo "🌐 Access the application:"
echo "  http://localhost:5000"
echo ""
echo "👨‍💼 Admin Login:"
echo "  Username: MAHIRJOD"
echo "  Password: MAHIRJOD"
echo ""
echo "🎉 Happy hosting with MAHIR HOISTING!"