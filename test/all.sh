#!/bin/bash
set -e
# Create package and move it to tmp
npm pack && mv defi-wonderland-crypto-husky-checks-*.tgz /tmp/crypto-husky-checks.tgz

####### Tests

bash test/1_find-crypto-keys.sh

####### End Tests

# Remove the package from temp
rm /tmp/crypto-husky-checks.tgz