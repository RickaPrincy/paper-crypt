#!/usr/bin/env bash
set -euo pipefail

read -rp "Texte à chiffrer : " plaintext
read -rsp "Passphrase : " passphrase
echo
read -rsp "Confirme la passphrase : " passphrase2
echo

if [[ "$passphrase" != "$passphrase2" ]]; then
    echo "Les passphrases ne correspondent pas." >&2
    exit 1
fi

ciphertext=$(printf '%s' "$plaintext" \
    | openssl enc -aes-256-cbc -pbkdf2 -iter 200000 -salt -base64 -A -pass fd:3 3<<<"$passphrase")

echo
echo "Texte chiffré (à recopier sur papier) :"
echo "$ciphertext"
