#!/bin/bash
cd "$(dirname "$BASH_SOURCE")"
read -p "Inserire l'hostname della chiave che si vuole codificare: " hostname
[[ ! -d "$hostname" ]] || [[ ! -f "$hostname/server.key" ]] && \
    echo "File $hostname/server.key non trovato" >&2 && \
    echo "È necessario prima creare una chiave usando new_site.sh" >&2 && \
    exit 1
cat "$hostname/server.key" | base64 > "$hostname/encoded.key"