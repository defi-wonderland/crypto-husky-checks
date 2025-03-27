set -e
# Create package and move it to tmp
npm pack && mv defi-wonderland-crypto-husky-checks-*.tgz /tmp/crypto-husky-checks.tgz
npm install -g pnpm

####### Tests

echo "Running tests with npm..."
sh test/1_find-crypto-keys.sh

echo "Running tests with pnpm..."
export PACKAGE_MANAGER=pnpm

# Try to run the test with pnpm
sh test/1_find-crypto-keys.sh
unset PACKAGE_MANAGER

####### End Tests

# Remove the package from temp
rm /tmp/crypto-husky-checks.tgz