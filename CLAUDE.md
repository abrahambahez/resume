# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Purpose

Resume/CV project using Markdown + Pandoc + XeLaTeX. Multiple CV variants for different contexts.

## Structure

```
resume/
├── resume-pm.es.md      # CV Tech PM (español)
├── resume-pm.en.md      # CV Tech PM (english)
├── cv-academico.md      # CV académico completo (español)
├── build.sh             # Script de compilación
├── template.tex         # Plantilla LaTeX
├── filters.lua          # Filtros Lua (center, languages)
├── output/              # PDFs generados
└── archive/             # Legacy (Quarkdown, YAML, etc.)
```

## Build Commands

```bash
./build.sh
```

Genera los 3 PDFs en `output/`:
- `resume-pm.es.pdf`
- `resume-pm.en.pdf`
- `cv-academico.pdf`

## Dependencies

```bash
sudo dnf install pandoc texlive-xetex
```

ETBembo font: download from [et-book](https://github.com/edwardtufte/et-book) and install to `~/.local/share/fonts/`

## Markdown/LaTeX Conventions

**Frontmatter YAML:**
```yaml
---
lang: es
geometry: margin=2cm
linestretch: 1.3
numbersections: false
---
```

**Header centrado:**
```markdown
::: {.center}
# Nombre
info de contacto
:::
```

**Fechas alineadas a la derecha:**
```markdown
\textbf{Título} \hfill 2020 – 2024
```

**Small caps:**
```markdown
[**texto**]{.smallcaps}
```

**Tabla de idiomas:**
```markdown
::: {.languages}
| Español | Inglés | Francés |
|---------|--------|---------|
| Nativo  | B1     | Comprensión |
:::
```

## Editing Content

Edit directly the `.md` files and run `./build.sh` to regenerate PDFs.
