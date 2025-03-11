#!/bin/bash
pandoc -s -o $1.html -f markdown+yaml_metadata_block $1.md
