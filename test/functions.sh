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
  npm install ../crypto-husky-checks.tgz
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
  echo -e "\e[0;31mERROR:\e[m $1"
  exit 1
}

ok() {
  echo -e "\e[0;32mOK\e[m"
}