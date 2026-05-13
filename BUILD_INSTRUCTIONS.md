# Compilación de snes9xgx

## Requisitos del Entorno

Este proyecto requiere las siguientes herramientas para compilarse:

### Herramientas Instaladas en el Contenedor

- **devkitPPC v13.1.0**: Compilador PowerPC para Nintendo Wii y GameCube
- **libogc2 v2.4.2**: Librería oficial de Wii/GameCube
- **portlibs**: Librerías precompiladas (libpng, freetype2, libogg, libvorbisidec, etc.)
- **Build essentials**: gcc, g++, make, binutils, etc.

## Compilación Rápida

### Opción 1: Script de Build (Recomendado)

```bash
# Compilar ambas plataformas (Wii + GameCube)
./build.sh

# Compilar solo Wii
./build.sh wii

# Compilar solo GameCube
./build.sh gc

# Limpiar artefactos de compilación
./build.sh clean
```

### Opción 2: Make directo

```bash
# Compilar Wii
make -f Makefile.wii

# Compilar GameCube
make -f Makefile.gc

# Compilar ambas
make all

# Limpiar
make clean
```

## Salida de Compilación

Los archivos generados se encuentran en:

- **Wii**: `executables/snes9xgx-wii.dol`
- **GameCube**: `executables/snes9xgx-gc.dol`

El formato `.dol` es el ejecutable estándar para Wii y GameCube.

## Variables de Entorno

El contenedor configura automáticamente:

```
DEVKITPRO=/opt/devkitpro
DEVKITPPC=/opt/devkitpro/devkitPPC
PORTLIBS=/opt/devkitpro/portlibs/ppc
```

## Solución de Problemas

### Error: "Please set DEVKITPPC in your environment"

El contenedor debería configurar automáticamente estas variables. Si no lo hace:

```bash
export DEVKITPRO=/opt/devkitpro
export DEVKITPPC=/opt/devkitpro/devkitPPC
export PORTLIBS=/opt/devkitpro/portlibs/ppc
export PATH=$DEVKITPPC/bin:$PATH
```

### Librería no encontrada (libpng, freetype, etc.)

Verifica que `portlibs` está correctamente instalado:

```bash
ls -la $PORTLIBS/lib/
```

Debería contener archivos como: `libpng.a`, `libfreetype.a`, etc.

## Estructura del Proyecto

```
source/
├── snes9x/          # Core del emulador Snes9x
├── gui/             # Interfaz gráfica
├── images/          # Recursos gráficos
├── lang/            # Archivos de idioma
├── sounds/          # Recursos de sonido
├── fonts/           # Fuentes TTF
└── [archivos .cpp/h] # Código principal

Makefiles:
├── Makefile         # Build general (ambas plataformas)
├── Makefile.wii     # Configuración específica para Wii
├── Makefile.gc      # Configuración específica para GameCube
└── Makefile.xenon   # Configuración específica para Xbox 360
```

## Configuración del Contenedor

El archivo `.devcontainer/Dockerfile` incluye:

1. **Base**: Ubuntu 22.04
2. **Herramientas de compilación**: gcc, g++, make, etc.
3. **devkitPPC**: Compilador PowerPC
4. **libogc2**: Librería de Wii/GameCube
5. **portlibs_ppc**: Librerías precompiladas

El archivo `.devcontainer/devcontainer.json` configura VS Code para usar este contenedor automáticamente.

## Extensiones VS Code Instaladas

- **C/C++ Extension Pack**: Para desarrollo en C/C++
- **Makefile Tools**: Para ejecución de tareas make

## Notas Importantes

- La primera compilación puede tardar varios minutos
- El contenedor descarga automáticamente los componentes necesarios durante la construcción
- Asegúrate de que tu conexión a internet es estable durante la construcción del contenedor
- Los archivos `.dol` generados pueden ejecutarse en un Wii o GameCube homebrewed
