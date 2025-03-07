[![Node.js CI](https://github.com/defi-wonderland/crypto-husky-checks/actions/workflows/node.js.yml/badge.svg?branch=main)](https://github.com/defi-wonderland/crypto-husky-checks/actions/workflows/node.js.yml)
[![license badge](https://img.shields.io/github/license/defi-wonderland/check-crypto-action)](./LICENSE)

# Crypto Husky Checks

Avoid committing sensitive information by installing these automated security checks in your precommit hook.

Features:

- Checks for crypto private keys on commited code

> :warning: **This repository does not support Windows OS**

---

## Requirements

```bash
yarn add -D husky
```

## Install

### For Husky v9+ (latest)

```bash
# Install dependencies
yarn add -D husky @defi-wonderland/crypto-husky-checks

# Initialize husky (creates .husky/pre-commit and updates package.json)
npx husky init

# Install the crypto checks
npx wonderland-crypto-husky-checks install
```

> **Note**: When using husky v9+, the `husky init` command adds `npm test` to the pre-commit hook by default. Our installation script will automatically remove this line to avoid running tests on every commit.

### For older Husky versions

```bash
# Install dependencies
yarn add -D husky @defi-wonderland/crypto-husky-checks

# Enable husky and setup the prepare script
npm pkg set scripts.prepare="husky && wonderland-crypto-husky-checks install"
npm run prepare
```

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
