set -e
# Create package and move it to tmp
npm pack

# Create a consistent package structure by unpacking and repacking with a specific structure
TEMP_DIR="/tmp/crypto-husky-checks-temp"
rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR/@defi-wonderland/crypto-husky-checks"

# Extract the package to the temp directory with the correct structure
tar -xzf defi-wonderland-crypto-husky-checks-*.tgz -C "$TEMP_DIR/@defi-wonderland/crypto-husky-checks" --strip-components=1

# Create a new tarball with the correct structure
cd "$TEMP_DIR"
tar -czf /tmp/crypto-husky-checks.tgz .
cd -

# Remove the original package
rm defi-wonderland-crypto-husky-checks-*.tgz

####### Tests

sh test/1_find-crypto-keys.sh

####### End Tests

# Remove the package from temp
rm /tmp/crypto-husky-checks.tgz
rm -rf "$TEMP_DIR"