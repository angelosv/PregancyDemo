#!/usr/bin/env python3
"""
Script para crear iconos placeholder temporales
Estos iconos son solo para que el proyecto compile
DEBES reemplazarlos con iconos reales antes de subir a TestFlight
"""

import os
from PIL import Image, ImageDraw, ImageFont

ICONSET_DIR = "PregancyDemo/Assets.xcassets/AppIcon.appiconset"

# Crear directorio si no existe
os.makedirs(ICONSET_DIR, exist_ok=True)

# Colores para el placeholder
BG_COLOR = (255, 107, 157)  # Rosa
TEXT_COLOR = (255, 255, 255)  # Blanco

def create_icon(size, filename):
    """Crea un icono placeholder de un tamaño específico"""
    img = Image.new('RGB', (size, size), color=BG_COLOR)
    draw = ImageDraw.Draw(img)
    
    # Intentar usar una fuente del sistema
    try:
        # Intentar diferentes fuentes comunes en macOS
        font_paths = [
            "/System/Library/Fonts/Helvetica.ttc",
            "/System/Library/Fonts/Supplemental/Helvetica.ttc",
            "/Library/Fonts/Arial.ttf"
        ]
        font = None
        for font_path in font_paths:
            if os.path.exists(font_path):
                try:
                    font = ImageFont.truetype(font_path, size // 3)
                    break
                except:
                    continue
        if font is None:
            font = ImageFont.load_default()
    except:
        font = ImageFont.load_default()
    
    # Dibujar texto "PD" centrado
    text = "PD"
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    x = (size - text_width) / 2
    y = (size - text_height) / 2
    
    draw.text((x, y), text, fill=TEXT_COLOR, font=font)
    
    # Guardar
    filepath = os.path.join(ICONSET_DIR, filename)
    img.save(filepath, 'PNG')
    print(f"✅ Creado: {filename} ({size}x{size})")

# Lista de iconos a crear según Contents.json
icons = [
    (40, "AppIcon-20x20@2x.png"),      # iPhone 20pt @2x
    (60, "AppIcon-20x20@3x.png"),      # iPhone 20pt @3x
    (58, "AppIcon-29x29@2x.png"),      # iPhone 29pt @2x
    (87, "AppIcon-29x29@3x.png"),      # iPhone 29pt @3x
    (80, "AppIcon-40x40@2x.png"),      # iPhone 40pt @2x
    (120, "AppIcon-40x40@3x.png"),     # iPhone 40pt @3x (REQUERIDO)
    (120, "AppIcon-60x60@2x.png"),    # iPhone 60pt @2x (REQUERIDO)
    (180, "AppIcon-60x60@3x.png"),    # iPhone 60pt @3x
    (20, "AppIcon-20x20@1x.png"),     # iPad 20pt @1x
    (40, "AppIcon-20x20@2x.png"),     # iPad 20pt @2x (reutiliza)
    (29, "AppIcon-29x29@1x.png"),     # iPad 29pt @1x
    (58, "AppIcon-29x29@2x.png"),     # iPad 29pt @2x (reutiliza)
    (40, "AppIcon-40x40@1x.png"),     # iPad 40pt @1x
    (80, "AppIcon-40x40@2x.png"),     # iPad 40pt @2x (reutiliza)
    (76, "AppIcon-76x76@1x.png"),     # iPad 76pt @1x
    (152, "AppIcon-76x76@2x.png"),    # iPad 76pt @2x (REQUERIDO)
    (167, "AppIcon-83.5x83.5@2x.png"), # iPad 83.5pt @2x
    (1024, "AppIcon-1024x1024.png"),  # App Store (REQUERIDO)
]

print("🎨 Creando iconos placeholder temporales...")
print("⚠️  IMPORTANTE: Estos son placeholders. DEBES reemplazarlos con iconos reales antes de TestFlight!")
print("")

# Crear cada icono
created_files = set()
for size, filename in icons:
    if filename not in created_files:
        create_icon(size, filename)
        created_files.add(filename)
    else:
        print(f"⏭️  Omitido (duplicado): {filename}")

print("")
print("✅ Iconos placeholder creados exitosamente")
print("")
print("📝 Próximos pasos:")
print("   1. El proyecto ahora debería compilar")
print("   2. Para crear iconos reales, usa: ./generate_app_icons.sh tu_imagen_1024x1024.png")
print("   3. Reemplaza los placeholders antes de subir a TestFlight")

