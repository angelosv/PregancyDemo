#!/bin/bash

# Script para crear un icono placeholder temporal
# Este icono es solo para que el proyecto compile
# DEBES reemplazarlo con un icono real antes de subir a TestFlight

ICONSET_DIR="PregancyDemo/Assets.xcassets/AppIcon.appiconset"
PLACEHOLDER_FILE="$ICONSET_DIR/AppIcon-1024.png"

echo "🎨 Creando icono placeholder temporal..."

# Crear directorio si no existe
mkdir -p "$ICONSET_DIR"

# Crear un icono placeholder simple usando sips
# Generamos un cuadrado de color con texto usando ImageIO
if command -v sips &> /dev/null; then
    # Crear un PNG temporal de 1024x1024 con un color sólido
    # Usamos Python para crear un PNG simple si está disponible
    if command -v python3 &> /dev/null; then
        python3 << EOF
from PIL import Image, ImageDraw, ImageFont
import os

# Crear imagen de 1024x1024
img = Image.new('RGB', (1024, 1024), color='#FF6B9D')
draw = ImageDraw.Draw(img)

# Intentar usar una fuente del sistema
try:
    font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", 120)
except:
    font = ImageFont.load_default()

# Dibujar texto centrado
text = "PD"
bbox = draw.textbbox((0, 0), text, font=font)
text_width = bbox[2] - bbox[0]
text_height = bbox[3] - bbox[1]
x = (1024 - text_width) / 2
y = (1024 - text_height) / 2

draw.text((x, y), text, fill='white', font=font)
img.save('$PLACEHOLDER_FILE', 'PNG')
print("✅ Icono placeholder creado")
EOF
    else
        # Si no hay Python/PIL, crear un PNG básico usando sips desde una imagen de color sólido
        # Crear un archivo temporal de color
        echo "⚠️  Python/PIL no disponible. Creando icono básico..."
        # Usar sips para crear un PNG de un color sólido
        # Esto requiere una imagen fuente, así que mejor crear un mensaje
        echo "📝 Por favor, crea manualmente un icono de 1024x1024 y guárdalo como:"
        echo "   $PLACEHOLDER_FILE"
        exit 1
    fi
else
    echo "❌ Error: sips no está disponible"
    exit 1
fi

# Copiar para las variantes
if [ -f "$PLACEHOLDER_FILE" ]; then
    cp "$PLACEHOLDER_FILE" "$ICONSET_DIR/AppIcon-1024-dark.png"
    cp "$PLACEHOLDER_FILE" "$ICONSET_DIR/AppIcon-1024-tinted.png"
    echo "✅ Iconos placeholder creados"
    echo ""
    echo "⚠️  IMPORTANTE: Este es un icono placeholder temporal."
    echo "   DEBES reemplazarlo con un icono real antes de subir a TestFlight."
    echo ""
    echo "   Para crear tu icono real, usa:"
    echo "   ./generate_app_icons.sh tu_imagen.png"
else
    echo "❌ No se pudo crear el icono placeholder"
    echo "   Por favor, crea manualmente un icono de 1024x1024"
fi

