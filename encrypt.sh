#!/usr/bin/env bash
set -euo pipefail

read -rp "Text to encrypt: " plaintext
read -rp "Confirm text to encrypt: " plaintext2

if [[ "$plaintext" != "$plaintext2" ]]; then
    echo "Texts do not match." >&2
    exit 1
fi

read -rp "Passphrase: " passphrase
read -rp "Confirm passphrase: " passphrase2

if [[ "$passphrase" != "$passphrase2" ]]; then
    echo "Passphrases do not match." >&2
    exit 1
fi

ciphertext=$(printf '%s' "$plaintext" \
    | openssl enc -aes-256-cbc -pbkdf2 -iter 200000 -salt -base64 -A -pass fd:3 3<<<"$passphrase")

echo
echo "Encrypted text (copy it onto paper):"
echo "$ciphertext"
