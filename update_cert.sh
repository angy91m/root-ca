#!/bin/bash
cd "$(dirname "$BASH_SOURCE")"
[[ ! -f ca.cnf ]] || \
[[ ! -f ca_req.cnf ]] || \
[[ ! -f ca.key ]] || \
[[ ! -f ca.crt ]] || \
[[ ! -f ca.srl ]] || \
[[ ! -f ca.idx ]] && \
    echo "Prima crea una nuova Root CA con generate_ca/generate.sh" >&2 && \
    exit 1

read -p "Inserire l'hostname del server che si vuole certificare: " hostname
[[ ! -f "$hostname/server.req" ]] && \
    echo "$hostname/server.req non trovato" >&2 && \
    echo "Genera un sito e automaticamente i certificati utilizzando new_site.sh" >&2 && \
    exit 2
openssl ca -config ca.cnf -in "$hostname/server.req" -out "$hostname/server.crt" -notext -batch 2> /dev/null
if [[ $? == "0" ]]; then
    cat "$hostname/server.crt" ca.crt > "$hostname/server_full.crt"
    echo ""
    echo "Il nuovo certificato è stato creato in $hostname"
    echo "Il file da utilizzare è server_full.crt"
else
    echo Errore >&2
    exit 4
fi