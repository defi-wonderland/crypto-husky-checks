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
  # Check if PACKAGE_MANAGER env var is set to pnpm
  if [ "${PACKAGE_MANAGER:-npm}" = "pnpm" ]; then
    install_pnpm
  else
    install_npm
  fi
}

install_npm() {
  npm install husky -D --silent
  npm install /tmp/crypto-husky-checks.tgz --silent
  npm pkg set scripts.prepare="husky && wonderland-crypto-husky-checks install" --silent

  # Run prepare script
  npm run prepare 1>/dev/null
}

install_pnpm() {
  pnpm add -D husky --silent
  pnpm add -D /tmp/crypto-husky-checks.tgz --silent
  pnpm pkg set scripts.prepare="husky && wonderland-crypto-husky-checks install" --silent

  # Run prepare script with pnpm and capture any errors
  echo "Running prepare with pnpm..."
  if ! pnpm prepare 1>/dev/null 2>&1; then
    echo "Error during pnpm prepare. Running again to see error:"
    pnpm prepare
    exit 1
  fi
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