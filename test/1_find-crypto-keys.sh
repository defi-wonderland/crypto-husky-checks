# Setup and install
. "$(dirname -- "$0")/functions.sh"
setup
install

####################################################
# Expect to copy file to husky folder
####################################################
SCRIPTS_PATH='.husky/wonderland';
expect 1 "[ ! -f ${SCRIPTS_PATH}/find-crypto-keys.sh ] && exit 2"
ok "Expect script correctly copied"

####################################################
# Expect script to be added on pre-commit file
####################################################
TEXT="'. \"\$(dirname \"\$0\")/wonderland/find-crypto-keys.sh\"'"
expect 0 "grep -q ${TEXT} .husky/pre-commit"
ok "Expect script on precommit file"

####################################################
# Expect commit to pass
####################################################
git add .
expect 0 "git commit -m foo -q"
ok "Expect commit to pass"

####################################################
# Expect commit with leak to fail
####################################################
cat <<EOF >testfile
first line
testLeak=abd3d28282b3b0e68918328527dbf73f6e79781bbaded0b24fdc3e43bf6fc56e
end line
EOF

git add .
expect 1 "git commit -m foo -q > /dev/null 2>&1"
ok "Expect commit with leaks to fail"

####################################################
# Expect commit fixed to pass
####################################################
cat <<EOF >testfile
first line
testLeak=fixed
end line
EOF

git add .
expect 0 "git commit -m foo -q"
ok "Expect commit fixed to pass"

####################################################
# Expect commit with multiple leaks to fail
####################################################
cat <<EOF >testfile
first line
testLeak1=abd3d28282b3b0e68918328527dbf73f6e79781bbaded0b24fdc3e43bf6fc561
testLeak2=abd3d28282b3b0e68918328527dbf73f6e79781bbaded0b24fdc3e43bf6fc562
testLeak3=abd3d28282b3b0e68918328527dbf73f6e79781bbaded0b24fdc3e43bf6fc563
end line
EOF

git add .
expect 1 "git commit -m foo -q > /dev/null 2>&1"
ok "Expect commit with multiple leaks to fail"

####################################################
# Expect commit with multiple files and leaks to fail
####################################################
cat <<EOF >testfile2
first line
testLeak4=abd3d28282b3b0e68918328527dbf73f6e79781bbaded0b24fdc3e43bf6fc564
testLeak5=abd3d28282b3b0e68918328527dbf73f6e79781bbaded0b24fdc3e43bf6fc565
testLeak6=abd3d28282b3b0e68918328527dbf73f6e79781bbaded0b24fdc3e43bf6fc566
end line
EOF

git add .
expect 1 "git commit -m foo -q > /dev/null 2>&1"
ok "Expect commit with multiple files and leaks to fail"

####################################################

# Clean test folder
clean