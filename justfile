set shell := ["bash", "-euo", "pipefail", "-c"]

template := "plugins/SamplePlugin"
dest_root := "plugins"

default:
    @just --list

init-new-plugin:
    #!/usr/bin/env bash
    set -euo pipefail

    read -r -p "Project name (PascalCase): " name

    if [[ ! "$name" =~ ^[A-Z][a-zA-Z0-9]*$ ]]; then
        echo "error: '$name' is not PascalCase (must start with an uppercase letter, letters and digits only)" >&2
        exit 1
    fi

    if [[ ! "$name" =~ [a-z] ]]; then
        echo "error: '$name' looks like ALLCAPS, not PascalCase" >&2
        exit 1
    fi

    target="{{dest_root}}/$name"

    if [[ -e "$target" ]]; then
        echo "error: $target already exists" >&2
        exit 1
    fi

    cp -R "{{template}}" "$target"
    echo "Created $target"
