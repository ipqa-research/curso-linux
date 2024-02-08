#!/bin/bash
# ~/.local/bin/fortran_project.sh

nombre=$1  # Primer argumento

# Crea una carpeta 
fpm new "$nombre"

# Ir a la nueva carpeta
cd "$nombre"

# Añade configuraciones generales de vscode al proyecto
git submodule add "git@github.com:ipqa-research/vscode-fortran.git" .vscode
