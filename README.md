# Resume: Markdown + Pandoc + XeLaTeX

Generate CV PDFs from Markdown using Pandoc with XeLaTeX.

## Dependencies

### System (Fedora)

```bash
sudo dnf install pandoc texlive-xetex
```

### ETBembo Font

Download from [et-book](https://github.com/edwardtufte/et-book/tree/gh-pages/et-book) and copy `.ttf` files to:

```bash
mkdir -p ~/.local/share/fonts
cp et-book-*.ttf ~/.local/share/fonts/
fc-cache -f
```

Verify installation:

```bash
fc-list | grep ETBembo
```

## Usage

```bash
./build.sh
```

Generates in `output/`:
- `resume-pm.es.pdf` - Tech PM CV (Spanish)
- `resume-pm.en.pdf` - Tech PM CV (English)
- `cv-academico.pdf` - Academic CV (Spanish)

## Structure

- `resume-pm.es.md` - Tech PM CV Spanish
- `resume-pm.en.md` - Tech PM CV English
- `cv-academico.md` - Full academic CV
- `template.tex` - LaTeX template
- `center.lua` - Lua filter for centering
- `build.sh` - Build script

## Limitations

- ETBembo lacks native small caps; `[text]{.smallcaps}` doesn't work properly
- For real small caps, use EB Garamond, Libertinus or Cormorant Garamond
