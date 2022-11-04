set -e
npm run build
cd dist && npm pack && mv crypto-husky-checks-*.tgz /tmp/crypto-husky-checks.tgz && cd ..

sh test/1_find-crypto-keys.sh