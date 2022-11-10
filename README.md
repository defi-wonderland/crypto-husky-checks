[![Node.js CI](https://github.com/defi-wonderland/crypto-husky-checks/actions/workflows/node.js.yml/badge.svg?branch=main)](https://github.com/defi-wonderland/crypto-husky-checks/actions/workflows/node.js.yml)
[![license badge](https://img.shields.io/github/license/defi-wonderland/check-crypto-action)](./LICENSE)

# Crypto Husky Checks

Avoid committing sensitive information by installing these automated security checks in your precommit hook.

Features:

- Checks for crypto private keys on commited code

---

## Requirements

```bash
yarn add -D husky
```

## Install

```bash
yarn add -D @defi-wonderland/crypto-husky-checks
npm set-script prepare "husky install && wonderland-crypto-husky-checks install"
npm run prepare
```

## Checks:

```

find-crypto-keys.sh - Checks for crypto private keys on commited code. Should be added as a precommit hook

```

## License

MIT license. Feel free to use, modify, and/or redistribute this software as you see fit. See the LICENSE file for more information.
