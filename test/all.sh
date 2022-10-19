set -e
yarn build
cd dist && yarn pack && mv crypto-husky-checks-*.tgz /tmp/crypto-husky-checks.tgz && cd ..

sh test/1_find-crypto-keys.sh