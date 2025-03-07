# Exit on error
set -eu

RESTORE='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'

setup() {
  name="$(basename -- $0)"
  testDir="/tmp/crypto-husky-checks-test-$name"
  echo
  echo "-----------------------------------"
  echo "+ $name"
  echo "-----------------------------------"
  echo
  # Create test directory
  rm -rf "$testDir"
  mkdir -p "$testDir"
  cd "$testDir"
  # Init git
  git init --quiet
  git config user.email "test@test"
  git config user.name "test"
  # Init package.json
  # npm_config_loglevel="error"
  npm init -y 1>/dev/null
}

install() {
  npm install husky -D --silent
  npm install /tmp/crypto-husky-checks.tgz --silent
  npm pkg set scripts.prepare="husky && wonderland-crypto-husky-checks install" --silent

  # Fix package structure for macOS test environment
  # On macOS, the package structure in tests is different from a normal npm installation
  if [ "$(uname)" = "Darwin" ] && [ -d "node_modules/src" ] && [ ! -d "node_modules/@defi-wonderland/crypto-husky-checks/src" ]; then
    echo "Fixing package structure for macOS test environment..."
    mkdir -p node_modules/@defi-wonderland/crypto-husky-checks/src
    cp node_modules/src/* node_modules/@defi-wonderland/crypto-husky-checks/src/ 2>/dev/null || true
  fi

  # Run prepare script
  npm run prepare 1>/dev/null
}

clean() {
  name="$(basename -- $0)"
  testDir="/tmp/crypto-husky-checks-test-$name"
  echo
  echo "-----------------------------------"
  echo "Cleaning $name"
  echo "-----------------------------------"
  echo
  cd ..
  rm -rf "$testDir"
}

expect() {
  set +e
  sh -c "$2"
  exitCode="$?"
  set -e
  if [ $exitCode != "$1" ]; then
    error "expect command \"$2\" to exit with code $1 (got $exitCode)"
  fi
}

error() {
  printf "\n${RED}ERROR:${RESTORE} $1 \n"
  exit 1
}

ok() {
  printf "${GREEN}OK${RESTORE} - $1 \n"
}