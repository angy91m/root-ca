#!/bin/bash
# 1: hostname, 2: password_file
cd "$(dirname "$BASH_SOURCE")"
[[ ! -f ca.cnf ]] || \
[[ ! -f ca_req.cnf ]] || \
[[ ! -f ca.key ]] || \
[[ ! -f ca.crt ]] || \
[[ ! -f ca.srl ]] || \
[[ ! -f ca.idx ]] && \
    echo "Prima crea una nuova Root CA con generate_ca/generate.sh" >&2 && \
    exit 1
[[ ! -f "$1/server.req" ]] && \
    echo "$1/server.req non trovato" >&2 && \
    echo "Genera un sito e automaticamente i certificati utilizzando new_site.sh" >&2 && \
    exit 2
openssl ca -passin file:$2 -config ca.cnf -in "$1/server.req" -out "$1/server.crt" -notext -batch 2> /dev/null
if [[ $? == "0" ]]; then
    cat "$1/server.crt" ca.crt > "$1/server_full.crt"
else
    echo Errore >&2 && \
    exit 4
fi