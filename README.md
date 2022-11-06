[![Node.js CI](https://github.com/defi-wonderland/crypto-husky-checks/actions/workflows/node.js.yml/badge.svg)](https://github.com/defi-wonderland/crypto-husky-checks/actions/workflows/node.js.yml)
[![license badge](https://img.shields.io/github/license/defi-wonderland/check-crypto-action)](./LICENSE)

# crypto-husky-checks

TODO Add desc

## Requirements

- Husky

```
npm install husky -D
npm set-script prepare "husky install"
npm run prepare
```

## Install

You can install Wonderland crypto checks for husky via npm or yarn:

`npm i -D @defi-wonderland/crypto-husky-checks`

This will add the check scripts inside `.husky/wonderland`

## Usage

After installing, you should manually add any of the check scripts into your husky hooks file.

Example for adding `find-crypto-keys` as a pre-commit hook on `linux | macos | windows`:

```
npx husky add .husky/pre-commit "" && echo '. "$(dirname "$0")/wonderland/find-crypto-keys.sh"' >> .husky/pre-commit
```

## Checks:

```

find-crypto-keys.sh - Checks for crypto private keys on commited code. Should be added as a precommit hook

```

## License

MIT license. Feel free to use, modify, and/or redistribute this software as you see fit. See the LICENSE file for more information.
