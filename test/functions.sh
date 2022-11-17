# Exit on error
set -eu

setup() {
  name="$(basename -- $0)"
  testDir="/tmp/crypto-husky-checks-test-$name"
  echo
  echo "-------------------"
  echo "+ $name"
  echo "-------------------"
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
  npm install ../crypto-husky-checks.tgz --silent
  npm set-script prepare "husky install && wonderland-crypto-husky-checks install" --silent
  npm run prepare --silent
  printf "\n"
}

clean() {
  name="$(basename -- $0)"
  testDir="/tmp/crypto-husky-checks-test-$name"
  echo "-------------------"
  echo "Cleaning $name"
  echo "-------------------"
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
  echo -e "\n\e[0;31mERROR:\e[m $1"
  exit 1
}

ok() {
  echo "\e[0;32mOK\e[m - $1"
}