#!/usr/bin/env bash
set -euo pipefail

read -rp "Encrypted text: " ciphertext
read -rp "Passphrase: " passphrase

if ! plaintext=$(printf '%s' "$ciphertext" \
    | openssl enc -d -aes-256-cbc -pbkdf2 -iter 200000 -base64 -A -pass fd:3 3<<<"$passphrase" 2>/dev/null); then
    echo "Decryption failed (wrong passphrase or corrupted text)." >&2
    exit 1
fi

echo
echo "Decrypted text:"
echo "$plaintext"
