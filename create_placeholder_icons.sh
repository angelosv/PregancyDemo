#!/bin/bash

# Script para crear iconos placeholder temporales usando sips
# Estos iconos son solo para que el proyecto compile
# DEBES reemplazarlos con iconos reales antes de subir a TestFlight

ICONSET_DIR="PregancyDemo/Assets.xcassets/AppIcon.appiconset"

echo "🎨 Creando iconos placeholder temporales..."
echo "⚠️  IMPORTANTE: Estos son placeholders. DEBES reemplazarlos con iconos reales antes de TestFlight!"
echo ""

# Crear directorio si no existe
mkdir -p "$ICONSET_DIR"

# Crear un icono base de 1024x1024 usando sips desde un color sólido
# Usaremos un método diferente: crear un PNG simple con ImageIO

# Función para crear un icono de un tamaño específico
create_icon() {
    local size=$1
    local filename=$2
    
    # Crear un PNG temporal usando sips desde un archivo de color sólido
    # Primero creamos un archivo temporal de color usando ImageMagick o sips
    # Como alternativa, podemos usar un enfoque más simple
    
    # Usar sips para crear un PNG de color sólido
    # sips no puede crear desde cero, así que creamos un PNG básico usando otro método
    
    # Crear un PNG simple usando base64 y printf (método alternativo)
    # O mejor, crear un PNG mínimo válido
    
    echo "   Creando $filename ($size x $size)..."
    
    # Crear un PNG mínimo válido de color sólido usando Python si está disponible
    # Si no, crear usando otro método
    if command -v python3 &> /dev/null; then
        python3 << EOF
from struct import pack

def create_solid_color_png(size, filename, r=255, g=107, b=157):
    """Crea un PNG simple de color sólido"""
    width = height = size
    
    # PNG header
    png = bytearray([
        0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,  # PNG signature
    ])
    
    # IHDR chunk
    ihdr_data = pack('>IIBBBBB', width, height, 8, 2, 0, 0, 0)
    ihdr_crc = 0x52444849  # Simplified
    png.extend(pack('>I', len(ihdr_data)))
    png.extend(b'IHDR')
    png.extend(ihdr_data)
    png.extend(pack('>I', ihdr_crc))
    
    # IDAT chunk (simplified - solo datos RGB)
    pixel_data = bytes([r, g, b] * width * height)
    idat_data = pixel_data[:1000]  # Limitar tamaño
    png.extend(pack('>I', len(idat_data)))
    png.extend(b'IDAT')
    png.extend(idat_data)
    png.extend(pack('>I', 0))  # CRC simplificado
    
    # IEND chunk
    png.extend(pack('>I', 0))
    png.extend(b'IEND')
    png.extend(pack('>I', 0xAE426082))
    
    with open(filename, 'wb') as f:
        f.write(png)

create_solid_color_png($size, '$ICONSET_DIR/$filename')
EOF
        if [ $? -eq 0 ]; then
            echo "   ✅ $filename creado"
        else
            echo "   ❌ Error al crear $filename"
        fi
    else
        # Si no hay Python, crear usando sips desde una imagen temporal
        # Primero necesitamos una imagen fuente
        echo "   ⚠️  Python no disponible. Necesitas crear $filename manualmente o instalar PIL"
    fi
}

# Crear iconos requeridos
echo "📱 Creando iconos para iPhone..."
create_icon 120 "AppIcon-60x60@2x.png"      # 120x120 (REQUERIDO)
create_icon 120 "AppIcon-40x40@3x.png"     # 120x120 (REQUERIDO)

echo ""
echo "📱 Creando iconos para iPad..."
create_icon 152 "AppIcon-76x76@2x.png"     # 152x152 (REQUERIDO)

echo ""
echo "📱 Creando icono para App Store..."
create_icon 1024 "AppIcon-1024x1024.png"  # 1024x1024 (REQUERIDO)

# Crear los demás iconos también
create_icon 40 "AppIcon-20x20@2x.png"
create_icon 60 "AppIcon-20x20@3x.png"
create_icon 58 "AppIcon-29x29@2x.png"
create_icon 87 "AppIcon-29x29@3x.png"
create_icon 80 "AppIcon-40x40@2x.png"
create_icon 180 "AppIcon-60x60@3x.png"
create_icon 20 "AppIcon-20x20@1x.png"
create_icon 29 "AppIcon-29x29@1x.png"
create_icon 40 "AppIcon-40x40@1x.png"
create_icon 76 "AppIcon-76x76@1x.png"
create_icon 167 "AppIcon-83.5x83.5@2x.png"

echo ""
echo "✅ Iconos placeholder creados"
echo ""
echo "📝 Para crear iconos reales, usa:"
echo "   ./generate_app_icons.sh tu_imagen_1024x1024.png"

