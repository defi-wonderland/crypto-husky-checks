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
  echo "install husky"
  npm install husky -D
  echo "install ../crypto-husky-checks.tgz"
  npm install ../crypto-husky-checks.tgz
  echo "set script"
  ls -al node_modules
  ls -al node_modules/.bin
  # rm -rf node_modules/.bin/husky.cmd
  rm -rf node_modules/.bin/husky.ps1
  npm pkg set scripts.prepareOne="husky install"
  npm pkg set scripts.prepareTwo="wonderland-crypto-husky-checks install"
  cat node_modules/.bin/wonderland-crypto-husky-checks
  echo "run prepareOne"
  npm run prepareOne
  echo "run prepareTwo"
  npm run prepareTwo
  npm pkg set scripts.prepare="husky install && wonderland-crypto-husky-checks install"
  npm run prepare 1>/dev/null
  echo "finish"
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