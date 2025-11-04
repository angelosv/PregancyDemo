# 📋 Configuración de Reachu SDK en PregnancyDemo

## Pasos para Configurar

### 1. Obtener API Key

Necesitas una API key de Reachu. Contacta al equipo de backend o usa la key de desarrollo.

### 2. Actualizar el archivo de configuración

Edita el archivo `Configuration/reachu-config.json` y reemplaza:

```json
"apiKey": "your-reachu-api-key-here"
```

Con tu API key real:

```json
"apiKey": "TU-API-KEY-AQUI"
```

### 3. Agregar el archivo al Bundle de Xcode

**IMPORTANTE**: El archivo debe estar incluido en el bundle de la app:

1. Abre el proyecto en Xcode
2. Selecciona el archivo `Configuration/reachu-config.json` en el navegador
3. En el panel derecho (File Inspector), asegúrate de que:
   - ✅ Está marcado en "Target Membership" → `PregancyDemo`
   - ✅ En "Build Phases" → "Copy Bundle Resources" debe aparecer el archivo

Si no aparece en "Copy Bundle Resources":
1. Ve a tu target → Build Phases
2. Expande "Copy Bundle Resources"
3. Haz clic en "+"
4. Selecciona `Configuration/reachu-config.json`

### 4. Verificar la configuración

Al ejecutar la app, deberías ver en la consola:

```
🚀 [PregnancyDemo] Loading Reachu SDK configuration...
🔧 [Config] Found config file: reachu-config.json
✅ [PregnancyDemo] Reachu SDK configured successfully
🎨 [PregnancyDemo] Theme: Pregnancy Demo Theme
🔑 [PregnancyDemo] API Key: KCXF10Y...
🌍 [PregnancyDemo] Environment: sandbox
```

## Estructura del Archivo

El archivo `reachu-config.json` contiene:

- **apiKey**: Tu clave de API de Reachu
- **environment**: `sandbox` (desarrollo) o `production` (producción)
- **theme**: Colores y temas para light/dark mode
- **cart**: Configuración del carrito flotante
- **network**: Configuración de timeouts y caché
- **ui**: Configuración de animaciones y UI
- **marketFallback**: País y moneda por defecto
- **localization**: Configuración de idiomas

## Ambientes Disponibles

- `sandbox` - Ambiente de desarrollo/testing
- `development` - Ambiente de desarrollo con más logs
- `production` - Ambiente de producción

## Troubleshooting

### Error 404 al cargar productos

**Causa**: API key incorrecta o no configurada

**Solución**:
1. Verifica que el API key en `reachu-config.json` sea correcto
2. Asegúrate de que el archivo esté en el bundle (ver paso 3)
3. Verifica que el ambiente sea correcto (`sandbox` para desarrollo)

### El archivo no se encuentra

**Causa**: El archivo no está incluido en el bundle

**Solución**:
1. Verifica que el archivo esté en la carpeta `Configuration/`
2. Asegúrate de que esté marcado en "Target Membership"
3. Verifica que aparezca en "Copy Bundle Resources"

### Error de compilación

**Causa**: JSON inválido

**Solución**:
1. Valida el JSON con un validador online
2. Verifica que todas las comas y llaves estén correctas
3. No uses comentarios en el JSON (no soportados)

