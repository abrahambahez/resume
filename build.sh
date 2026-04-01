#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"

check_deps() {
    local missing=()
    command -v pandoc >/dev/null || missing+=("pandoc")
    command -v xelatex >/dev/null || missing+=("xelatex")
    fc-list | grep -q "ETBembo" || missing+=("ETBembo font")

    if [[ ${#missing[@]} -gt 0 ]]; then
        echo "Missing: ${missing[*]}"
        echo "See README.md for installation instructions"
        exit 1
    fi
}

build_pdf() {
    local input="$1"
    local output="$2"
    pandoc "$input" -o "$output" \
        --template=template.tex \
        --pdf-engine=xelatex \
        --lua-filter=filters.lua
    echo "Generated: $output"
}

check_deps
mkdir -p output

build_pdf resume-pm.es.md output/resume-pm.es.pdf
build_pdf resume-pm.en.md output/resume-pm.en.pdf
build_pdf academic.es.md output/academic.es.pdf
build_pdf academic.en.md output/academic.en.pdf

echo "All PDFs generated in output/"
