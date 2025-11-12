# 🚀 Guía para Build de TestFlight - PregnancyDemo

Esta guía te ayudará a preparar la app PregnancyDemo para subir a TestFlight.

## ✅ Checklist Pre-Build

### 1. Iconos de Aplicación

**Requisitos:**
- Icono principal: 1024x1024 píxeles (PNG, sin transparencia)
- Opcional: Variantes para modo oscuro y tinted

**Pasos:**

1. **Prepara tu imagen fuente:**
   - Crea o consigue una imagen de al menos 1024x1024 píxeles
   - Formato: PNG, JPG, o cualquier formato soportado por macOS
   - La imagen debe ser cuadrada (1:1)

2. **Genera los iconos:**
   ```bash
   cd /Users/angelo/PregancyDemo
   ./generate_app_icons.sh tu_imagen.png
   ```

3. **O manualmente:**
   - Abre tu imagen en Preview o cualquier editor
   - Exporta como PNG de 1024x1024
   - Guarda como `PregancyDemo/Assets.xcassets/AppIcon.appiconset/AppIcon-1024.png`
   - Copia el mismo archivo como `AppIcon-1024-dark.png` y `AppIcon-1024-tinted.png`

4. **Verifica en Xcode:**
   - Abre el proyecto en Xcode
   - Selecciona el target "PregancyDemo"
   - Ve a la pestaña "General"
   - Verifica que los iconos aparezcan en "App Icons and Launch Screen"

### 2. Configuración del Proyecto

**Ya configurado:**
- ✅ Bundle Identifier: `reachudev.PregancyDemo`
- ✅ Versión: 1.0 (Marketing Version)
- ✅ Build: 1 (Current Project Version)
- ✅ iOS Deployment Target: 15.0
- ✅ Development Team: U4R2B2U7E6
- ✅ Code Signing: Automatic

**Para actualizar la versión antes de subir:**
- En Xcode: Target → General → Version (Marketing Version)
- O edita `project.pbxproj` y busca `MARKETING_VERSION` y `CURRENT_PROJECT_VERSION`

### 3. Info.plist

**Ya creado:** `PregancyDemo/Info.plist`
- ✅ Display Name: "Pregnancy Demo"
- ✅ Bundle Identifier configurado
- ✅ Orientaciones soportadas configuradas
- ✅ Scene Manifest configurado

### 4. Verificaciones Finales

**Antes de hacer el build:**

1. **Abre el proyecto en Xcode:**
   ```bash
   open PregancyDemo.xcodeproj
   ```

2. **Verifica el Scheme:**
   - Selecciona "Any iOS Device" o un dispositivo físico
   - NO uses simulador para builds de TestFlight

3. **Verifica Code Signing:**
   - Ve a Target → Signing & Capabilities
   - Asegúrate de que "Automatically manage signing" esté activado
   - Verifica que tu Development Team esté seleccionado

4. **Verifica que los iconos estén presentes:**
   - Ve a `PregancyDemo/Assets.xcassets/AppIcon.appiconset/`
   - Debe haber al menos `AppIcon-1024.png`

## 📦 Crear el Build para TestFlight

### Opción 1: Desde Xcode (Recomendado)

1. **Selecciona el Scheme:**
   - En la barra superior, selecciona "Any iOS Device" (no simulador)

2. **Product → Archive:**
   - Ve a `Product → Archive`
   - Espera a que compile y archive

3. **Organizer:**
   - Se abrirá el Organizer automáticamente
   - Selecciona tu archive más reciente
   - Click en "Distribute App"

4. **Distribución:**
   - Selecciona "App Store Connect"
   - Sigue el asistente
   - Selecciona "Upload" (no "Export")
   - Espera a que termine el upload

### Opción 2: Desde Terminal (xcodebuild)

```bash
cd /Users/angelo/PregancyDemo

# Limpiar build anterior
xcodebuild clean -project PregancyDemo.xcodeproj -scheme PregancyDemo

# Crear archive
xcodebuild archive \
  -project PregancyDemo.xcodeproj \
  -scheme PregancyDemo \
  -configuration Release \
  -archivePath ./build/PregancyDemo.xcarchive \
  CODE_SIGN_IDENTITY="Apple Development" \
  DEVELOPMENT_TEAM="U4R2B2U7E6"

# Exportar para App Store (requiere más configuración)
# Mejor usar Xcode Organizer para esto
```

## 🎯 Después del Upload

1. **Ve a App Store Connect:**
   - https://appstoreconnect.apple.com
   - Ve a "My Apps" → "PregnancyDemo" (o créala si no existe)

2. **Configura la app en App Store Connect:**
   - Si es la primera vez, completa la información de la app
   - Bundle ID debe coincidir: `reachudev.PregancyDemo`

3. **Espera el procesamiento:**
   - El build aparecerá en "TestFlight" después de unos minutos
   - Estado: "Processing" → "Ready to Submit" → "Ready to Test"

4. **Agrega información de TestFlight:**
   - Descripción de la prueba
   - Notas de la versión
   - Agrega testers internos o externos

## ⚠️ Problemas Comunes

### Error: "Missing App Icon"
- **Solución:** Asegúrate de que `AppIcon-1024.png` existe en `AppIcon.appiconset/`
- Verifica que el archivo esté agregado al target en Xcode

### Error: "Invalid Bundle Identifier"
- **Solución:** Verifica que el Bundle ID en Xcode coincida con el de App Store Connect
- Debe ser: `reachudev.PregancyDemo`

### Error: "Code Signing Failed"
- **Solución:** 
  - Ve a Target → Signing & Capabilities
  - Verifica que tu Development Team esté seleccionado
  - Asegúrate de tener los certificados correctos en Keychain

### Error: "iOS Deployment Target too high"
- **Solución:** Ya corregido a iOS 15.0 (compatible con el SDK)

## 📝 Notas Adicionales

- **Versión del Build:** Incrementa `CURRENT_PROJECT_VERSION` cada vez que subas un nuevo build
- **Marketing Version:** Cambia `MARKETING_VERSION` solo cuando publiques una nueva versión
- **Iconos:** Los iconos deben ser PNG sin transparencia. iOS aplicará las esquinas redondeadas automáticamente.

## 🔗 Enlaces Útiles

- [App Store Connect](https://appstoreconnect.apple.com)
- [TestFlight Documentation](https://developer.apple.com/testflight/)
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)

---

**Última actualización:** $(date)
**Versión del proyecto:** 1.0 (Build 1)

