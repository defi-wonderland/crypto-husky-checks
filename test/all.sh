set -e
npm pack && mv defi-wonderland-crypto-husky-checks-*.tgz /tmp/crypto-husky-checks.tgz

sh test/1_find-crypto-keys.sh