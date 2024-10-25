# Session Types + OCaml

Los programas utilizan [FuSe](https://github.com/boystrange/FuSe), una implementación de binary session types en OCaml.

*Nota: por comodidad se incluye la librería directamente en este repo anclada a la versión utilizada al momento de cursar la materia.*

## Setup

1. Instalar OCaml en tu sistema.
2. Correr `make` dentro de la carpeta `fuse`.

## Compilar programas

Reemplazar `<filename>` con el basename de algún archivo dentro de la carpeta `src`, es decir el nombre del archivo sin la extensión `.ml`.

- **Build**: `make <filename>`
- **Run**: `./bin/<filename>`
- **Session Types**: `make <filename>.st`
- **OCaml Types**: `make <filename>.t`
