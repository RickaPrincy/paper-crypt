# paper-crypt

Two bash scripts to encrypt text and keep it on paper instead of in the cloud.

- `encrypt.sh` asks for a text and a passphrase, and prints the encrypted result as a single base64 line, short enough to copy by hand.
- `decrypt.sh` asks for that encrypted text and the passphrase, and recovers the original text.

## Requirements

- `bash`
- `openssl`

## Usage

```sh
./encrypt.sh
# Text to encrypt: my secret
# Passphrase: ********
# Confirm passphrase: ********
#
# Encrypted text (copy it onto paper):
# U2FsdGVkX1+uvC36MAYj/j0FTVzdy/hvtp64iowEUYG0hsov1sEE/jbLy5btpRF5
```

```sh
./decrypt.sh
# Encrypted text: U2FsdGVkX1+uvC36MAYj/j0FTVzdy/hvtp64iowEUYG0hsov1sEE/jbLy5btpRF5
# Passphrase: ********
#
# Decrypted text:
# my secret
```

## Technical details

- AES-256-CBC encryption via OpenSSL, PBKDF2 key derivation (200000 iterations), random salt.
- Output base64-encoded on a single line (no line breaks), so it stays copyable by hand.
- The passphrase is passed to `openssl` via a file descriptor rather than as an argument, so it never appears in the process list (`ps`).

Without the exact passphrase, the encrypted text is useless: there is no way to recover it.
