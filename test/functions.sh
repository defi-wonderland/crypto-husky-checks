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

  # Debug output to understand directory structure
  echo "OS: $(uname)"
  echo "Directory structure:"
  ls -la node_modules/
  if [ -d "node_modules/src" ]; then
    echo "Contents of node_modules/src:"
    ls -la node_modules/src/
  else
    echo "node_modules/src directory does not exist"
  fi
  
  # Check if the package is installed in the expected location
  if [ -d "node_modules/@defi-wonderland" ]; then
    echo "Contents of node_modules/@defi-wonderland:"
    ls -la node_modules/@defi-wonderland/
    if [ -d "node_modules/@defi-wonderland/crypto-husky-checks" ]; then
      echo "Contents of node_modules/@defi-wonderland/crypto-husky-checks:"
      ls -la node_modules/@defi-wonderland/crypto-husky-checks/
    fi
  else
    echo "node_modules/@defi-wonderland directory does not exist"
  fi

  # Fix package structure for macOS test environment
  # On macOS, the package structure in tests is different from a normal npm installation
  if [ "$(uname)" = "Darwin" ]; then
    echo "Running macOS-specific fix..."
    
    # Try to find the script file
    echo "Searching for find-crypto-keys.sh:"
    find node_modules -name "find-crypto-keys.sh" -type f
    
    # Create the expected directory structure
    mkdir -p node_modules/@defi-wonderland/crypto-husky-checks/src
    
    # Try different copy strategies
    if [ -d "node_modules/src" ]; then
      echo "Copying from node_modules/src/"
      cp -v node_modules/src/* node_modules/@defi-wonderland/crypto-husky-checks/src/ 2>/dev/null || true
    fi
  fi

  # Run prepare script
  echo "Running prepare script..."
  npm run prepare
  echo "Prepare script completed with status: $?"
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