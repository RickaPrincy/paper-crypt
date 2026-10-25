#!/usr/bin/env bash
set -euo pipefail

read -rp "Texte chiffré : " ciphertext
read -rsp "Passphrase : " passphrase
echo

if ! plaintext=$(printf '%s' "$ciphertext" \
    | openssl enc -d -aes-256-cbc -pbkdf2 -iter 200000 -base64 -A -pass fd:3 3<<<"$passphrase" 2>/dev/null); then
    echo "Échec du déchiffrement (mauvaise passphrase ou texte corrompu)." >&2
    exit 1
fi

echo
echo "Texte déchiffré :"
echo "$plaintext"
