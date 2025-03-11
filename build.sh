#!/bin/bash

pandoc $1.md -f markdown+yaml_metadata_block \
  --template templates/jb2resume.latex \
  -o $1.pdf

  open $1.pdf
