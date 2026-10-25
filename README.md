# paper-crypt

Deux scripts bash pour chiffrer un texte et le garder sur papier plutôt que dans le cloud.

- `encrypt.sh` demande un texte et une passphrase, et affiche le résultat chiffré sous forme d'une seule ligne base64, assez courte pour être recopiée à la main.
- `decrypt.sh` demande ce texte chiffré et la passphrase, et retrouve le texte original.

## Prérequis

- `bash`
- `openssl`

## Utilisation

```sh
./encrypt.sh
# Texte à chiffrer : mon secret
# Passphrase : ********
# Confirme la passphrase : ********
#
# Texte chiffré (à recopier sur papier) :
# U2FsdGVkX1+uvC36MAYj/j0FTVzdy/hvtp64iowEUYG0hsov1sEE/jbLy5btpRF5
```

```sh
./decrypt.sh
# Texte chiffré : U2FsdGVkX1+uvC36MAYj/j0FTVzdy/hvtp64iowEUYG0hsov1sEE/jbLy5btpRF5
# Passphrase : ********
#
# Texte déchiffré :
# mon secret
```

## Détails techniques

- Chiffrement AES-256-CBC via OpenSSL, dérivation de clé PBKDF2 (200000 itérations), sel aléatoire.
- Sortie encodée en base64 sur une seule ligne (pas de retours à la ligne), pour rester copiable à la main.
- La passphrase est transmise à `openssl` via un descripteur de fichier plutôt qu'en argument, pour ne pas apparaître dans la liste des processus (`ps`).

Sans la passphrase exacte, le texte chiffré est inutilisable : il n'y a aucun moyen de le retrouver.
