. "$(dirname -- "$0")/functions.sh"
setup
install

# Expect to copy file to husky folder
cd .husky
cd ..
SCRIPTS_PATH='.husky/wonderland';
expect 1 "[ ! -f ${SCRIPTS_PATH}/find-crypto-keys.sh ] && exit 2"