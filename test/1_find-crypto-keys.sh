# Setup and install
. "$(dirname -- "$0")/functions.sh"
setup
install

# Expect to copy file to husky folder
SCRIPTS_PATH='.husky/wonderland';
expect 1 "[ ! -f ${SCRIPTS_PATH}/find-crypto-keys.sh ] && exit 2"
ok "Expect script correctly copied"

# Expect script to be added on pre-commit file
TEXT="'. \"\$(dirname \"\$0\")/wonderland/find-crypto-keys.sh\"'"
expect 0 "grep -q ${TEXT} .husky/pre-commit"
ok "Expect script on precommit file"

# Expect commit to pass
git add .
expect 0 "git commit -m foo -q"
ok "Expect commit to pass"

# Expect commit with leak to fail
cat <<EOF >testfile
first line
testLeak=abd3d28282b3b0e68918328527dbf73f6e79781bbaded0b24fdc3e43bf6fc56e
third line
EOF

git add .
expect 1 "git commit -m foo -q > /dev/null 2>&1"
ok "Expect commit to fail"

# Clean test folder
clean