# root-ca



## Se vuoi creare una nuova Root CA

Clona il branch master e personalizza il file `ca_req.cnf`.

La folder `site.test` e il file `server_req.cnf` al suo interno sono un esempio dei file necessari per creare i certificati per un nuovo sito.

## Se vuoi gestire i certificati di un progetto

Clona il branch del progetto, gestisci i certificati e pusha un nuovo commit nel branch del progetto.

## Utilizzo

### Creazione Root CA

Per creare una nuova Root CA usa lo script `generate.sh` all'interno della directory `generate_ca`. Usa una password sicura e conservala.

Una volta creata una Root CA è possibile firmare i certificati dei siti di cui si necessita.

### Creazione nuovo sito

Per creare un nuovo sito, creare una nuova cartella col nome corrispondente all'hostname del dominio che si vuole creare. Copiare un file `server_req.cnf` da un qualsiasi sito già esistente (ad esempio `site.test`) nella cartella del nuovo sito e personalizzarlo nei campi necessari. Avviare lo script `new_site.sh` e seguire le istruzioni.

Verranno creati alcuni file, tra cui la chiave `server.key` e il certificato server `server_full.crt` necessari per i server internet.

**È SCONSIGLIATO CONSERVARE I FILE `server.key` ALL'INTERNO DEL PROGETTO GIT**
**LEGGERE LA SEZIONE DEDICATA ALLA CONSERVAZIONE DELLE CHIAVI**

Infine aggiungere le modifiche a git, eseguire il commit e fare il push.

### Conservazione chiavi

Il file `server.key` può essere spostato e conservato al sicuro e non è necessario per l'emissione di certificati aggiornati.

Se si ha necessità di salvarlo come stringa è possibile utilizzare gli script `encode_key.sh` che cercherà il file `server.key` all'interno della cartella indicata e salverà il contenuto in base64 all'interno di `encoded.key`.

Viceversa è possibile utilizzare lo script `decode_key.sh` per eseguire l'operazione inversa.

**È SCONSIGLIATO CONSERVARE I FILE `server.key` E `encoded.key` ALL'INTERNO DEL PROGETTO GIT**

### Emissione certificati aggiornati

Alla scadenza dei certificati emessi alla creazione del sito (dopo 397 giorni) è possibile aggiornarli per un nuovo ciclo di 397 giorni utilizzando lo script `update_cert.sh`.

Infine aggiungere le modifiche a git, eseguire il commit e fare il push.