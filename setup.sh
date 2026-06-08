#!/bin/bash

echo "🚀 NE HOST Installation Script"

# Check Python version
python_version=$(python3 --version 2>&1 | grep -Po '(?<=Python )\d+\.\d+')
required_version="3.8"

if [ "$(printf '%s\n' "$required_version" "$python_version" | sort -V | head -n1)" != "$required_version" ]; then 
    echo "❌ Python $required_version or higher is required. Found: $python_version"
    exit 1
fi

echo "✅ Python $python_version found"

# Create virtual environment
echo "📦 Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Install requirements
echo "📥 Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p storage/instances
mkdir -p static/uploads
mkdir -p templates/web

# Set permissions
echo "🔐 Setting permissions..."
chmod -R 755 storage
chmod -R 755 static

# Create default profile picture if not exists
if [ ! -f "static/uploads/default.png" ]; then
    echo "🖼️ Creating default profile picture..."
    # You can add a default image here or download from URL
    touch static/uploads/default.png
fi

echo "✅ Setup complete!"
echo ""
echo "To start the server:"
echo "  source venv/bin/activate"
echo "  python app.py"
echo ""
echo "Or with custom port:"
echo "  python app.py --port 8080"