#!/bin/bash

if [[ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" || "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]]; then
  echo "Windows is not supported, I would seriously consider using WSL..."
  exit 1;
fi

REPOSITORY_NAME="@defi-wonderland/crypto-husky-checks"
SCRIPT_DIR="$(cd "$(dirname "$0")"; cd ..; pwd)/$REPOSITORY_NAME/src"
HUSKY_DIR=".husky"
INSTALL_DIR_NAME="wonderland"
INSTALL_DIR="$HUSKY_DIR/$INSTALL_DIR_NAME"
PRE_COMMIT_FILE="$HUSKY_DIR/pre-commit"
SCRIPTS=("find-crypto-keys.sh")

install()
{
  # fail if husky install was not run
  if [ ! -d $HUSKY_DIR ]; then
    echo "Husky must be configured before setting up Wonderland Husky Checks"
    exit 1;
  fi

  # create .husky wonderland directory from scratch
  rm -rf $INSTALL_DIR
  mkdir $INSTALL_DIR

  # git ignore everything inside wonderland directory
  echo "*" > $INSTALL_DIR/.gitignore

  # create pre-commit file if needed
  if [ ! -f $PRE_COMMIT_FILE ]; then
    npx husky add $PRE_COMMIT_FILE ""
  fi

  for script in "${SCRIPTS[@]}"
  do
    # copy script to wonderland directory
    cp "$SCRIPT_DIR/$script" "$INSTALL_DIR/"

    # add script to pre-commit if needed
    if ! grep -q $script $PRE_COMMIT_FILE; then
      tee -a $PRE_COMMIT_FILE << EOF

. "\$(dirname "\$0")/$INSTALL_DIR_NAME/$script"
EOF
fi > /dev/null
  done

  echo "Wonderland Husky Checks configured succesfully"
}

uninstall()
{
  # remove installation directory
  rm -rf $INSTALL_DIR

  # remove wonderland lines from the pre-commit file
  sed -i '' -e "/\/$INSTALL_DIR_NAME\//d" $PRE_COMMIT_FILE

  echo "Wonderland Husky Checks uninstalled succesfully"
}

case $1 in
  install)
    install
    ;;

  uninstall)
    uninstall
    ;;

  *)
    echo "Unrecognized command $2"
    ;;
esac