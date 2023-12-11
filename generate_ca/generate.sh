#!/bin/bash
cd "$(dirname "$BASH_SOURCE")/.."
[[ -f ca.key ]] || [[ -f ca.crt ]] || [[ -f ca.srl ]] || [[ -f ca.idx ]] && \
    echo "È necessario cancellare i file della vecchia CA prima di generarne una nuova" >&2 && \
    echo "
    - ca.crt
    - ca.key
    - ca.idx
    - ca.srl" >&2 && \
    exit 1

echo "Inserire la password per la nuova chiave ROOT CA che si andrà a generare" && \
openssl genrsa -des3 -out ca.key 2048 && \
echo "" && \
echo "Reinserire la password per generare un nuovo certificato ROOT CA con la chiave appena creata" && \
echo "Il certificato sarà valido per 10 anni" && \
openssl req -x509 -config ca_req.cnf -new -nodes -key ca.key -sha256 -days 3652 -out ca.crt && \
echo 01 > ca.srl && \
touch ca.idx || \
    echo Errore >&2 && \
    exit 2