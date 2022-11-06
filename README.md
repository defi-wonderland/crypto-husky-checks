# crypto-husky-checks

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

Example for adding `find-crypto-keys` as a pre-commit hook on `linux | macos`:

```
npx --package=husky -c "husky add .husky/pre-commit '. \"\$(dirname \"\$0\")/wonderland/find-crypto-keys.sh\"'"
```

> The npx husky command can fail, it can't escape the wrong characters depending on envs and OS.

> If that happens, please add the line manually to the .husky/pre-commit file.

> Related: https://github.com/npm/cli/issues/3067

## Checks:

```

find-crypto-keys.sh - Checks for crypto private keys on commited code. Should be added as a precommit hook

```

## License

MIT license. Feel free to use, modify, and/or redistribute this software as you see fit. See the LICENSE file for more information.
