[![Node.js CI](https://github.com/defi-wonderland/crypto-husky-checks/actions/workflows/node.js.yml/badge.svg?branch=main)](https://github.com/defi-wonderland/crypto-husky-checks/actions/workflows/node.js.yml)
[![license badge](https://img.shields.io/github/license/defi-wonderland/check-crypto-action)](./LICENSE)

# Crypto Husky Checks

Avoid committing sensitive information by installing these automated security checks in your precommit hook.

Features:

- Checks for crypto private keys on commited code

> :warning: **This repository does not support Windows OS**

---

## Install

```bash
# Install the latest versions (will be fixed to the current latest version)
npm add -D husky@latest @defi-wonderland/crypto-husky-checks@latest

# Enable husky and setup the prepare script
npm pkg set scripts.prepare="husky && wonderland-crypto-husky-checks install"
npm run prepare
```

> **Note**: Using `@latest` installs the exact version that is latest at the time of installation, not a version range. This means your package.json will have fixed versions like `"husky": "9.1.7"` without any caret (`^`) or tilde (`~`) prefix.

## Troubleshooting

If you encounter an error like this on macOS:

```
cp: .../node_modules/@defi-wonderland/crypto-husky-checks/@defi-wonderland/crypto-husky-checks/src/find-crypto-keys.sh: No such file or directory
```

This is a known issue with path construction on macOS that has been fixed in the latest version. Please update to the latest version of the package.

## Checks:

```
find-crypto-keys.sh - Checks for crypto private keys on commited code. Should be added as a precommit hook
```

## License

MIT license. Feel free to use, modify, and/or redistribute this software as you see fit. See the LICENSE file for more information.
