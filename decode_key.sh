#!/bin/bash
cd "$(dirname "$BASH_SOURCE")"
read -p "Inserire l'hostname della chiave che si vuole decodificare: " hostname
[[ ! -d "$hostname" ]] || [[ ! -f "$hostname/encoded.key" ]] && \
    echo "File $hostname/encoded.key non trovato" >&2 && \
    echo "È necessario prima inserire una chiave codificata col nome 'encoded.key' nella directory del sito" >&2 && \
    exit 1
cat "$hostname/encoded.key" | base64 --decode > "$hostname/server.key"