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
if [[ ! -d "$hostname" ]] || [[ ! -f "$hostname/server_req.cnf" ]]; then
    echo "Prima crea una directory chiamata $hostname e poi copia un file server_req.cnf (prendendo come esempio le cartelle degli altri server) e cambia i campi relativi all'hostname con '$hostname'" >&2
    exit 2
elif [[ $(ls "$hostname" | wc -l) -eq "0" ]]; then
    echo "Prima copia un file server_req.cnf all'interno di $hostname (prendendo come esempio le cartelle degli altri server) e cambia i campi relativi all'hostname con '$hostname'" >&2
    exit 3
elif [[ $(ls "$hostname" | wc -l) -ne "1" ]]; then
    echo "Prima elimina qualsiasi file all'interno di $hostname all'infuori di server_req.cnf" >&2
    exit 4
fi
openssl req -newkey rsa -config "$hostname/server_req.cnf" -nodes -keyout "$hostname/server.key" -out "$hostname/server.req" -batch && \
printf "$hostname\n" | ./update_cert.sh && \
echo "" && \
echo "Chiave e certificato completo sono stati creati nella cartella $hostname" && \
echo "I file da utilizzare sono server_full.crt e server.key" && \
echo "Conserva server.key in un posto sicuro"