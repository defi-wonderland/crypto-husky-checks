#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
INSTALL_DIR=".husky/wonderland"

install()
{
  # fail if husky install was not run
  if [ ! -d ".husky" ]; then
    echo "Husky must be configured before setting up @defi-wonderland/crypto-husky-checks"
    exit 1;
  fi

  # create .husky wonderland directory from scratch
  rm -rf $INSTALL_DIR
  mkdir $INSTALL_DIR

  # git ignore everything inside wonderland directory
  echo "*" > $INSTALL_DIR/.gitignore

  # copy scripts to wonderland directory
  cp "$SCRIPT_DIR/find-crypto-keys.sh" "$INSTALL_DIR/"

  # create pre-commit file if needed
  if [ ! -f ".husky/pre-commit" ]; then
    npx husky add .husky/pre-commit ""
  fi

  # add find-crypto-keys script to pre-commit if needed
  if [ ! grep -q "find-crypto-keys\.sh" "./.husky/pre-commit" ]; then
    cat <<EOF >./.husky/pre-commit
    . "$(dirname "$0")/wonderland/find-crypto-keys.sh"
    EOF

    # echo '. "$(dirname "$0")/wonderland/find-crypto-keys.sh"' >> .husky/pre-commit
  fi

  echo "@defi-wonderland/crypto-husky-checks configured succesfully"
}

uninstall()
{
  # remove installation directory
  rm -rf $INSTALL_DIR

  # remove lines containing wonderland from the pre-commit file
  # TODO

  echo "@defi-wonderland/crypto-husky-checks uninstalled succesfully"
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