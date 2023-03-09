#!/bin/bash; C:/Program\ Files/Git/bin/bash.exe

REPOSITORY_NAME="@defi-wonderland/crypto-husky-checks"

if [[ "$OSTYPE" == darwin* || "$OSTYPE" == linux* ]]; then
  # Run script for MacOS and Linux
  SCRIPT_DIR="$(cd "$(dirname "$0")"; cd ..; pwd)/$REPOSITORY_NAME/src"
elif [[ "$OSTYPE" == msys* || "$OSTYPE" == cygwin* ]]; then
  # Run script for Windows
  SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
else
  echo "Unknown operating system"
  exit 1;
fi

SCRIPT_DIR="$(cd "$(dirname "$0")"; cd ..; pwd)/$REPOSITORY_NAME/src"
HUSKY_DIR=".husky"
INSTALL_DIR_NAME="wonderland"
INSTALL_DIR="$HUSKY_DIR/$INSTALL_DIR_NAME"
PRE_COMMIT_FILE="$HUSKY_DIR/pre-commit"
SCRIPTS=("find-crypto-keys.sh")

install()
{
  echo "*** 1"
  # fail if husky install was not run
  if [ ! -d $HUSKY_DIR ]; then
    echo "*** 2"
    echo "Husky must be configured before setting up Wonderland Husky Checks"
    exit 1;
  fi

  echo "*** 3"
  # create .husky wonderland directory from scratch
  rm -rf $INSTALL_DIR
  echo "*** 4"
  mkdir $INSTALL_DIR
  echo "*** 5"

  # git ignore everything inside wonderland directory
  echo "*" > $INSTALL_DIR/.gitignore
  echo "*** 6"

  # create pre-commit file if needed
  if [ ! -f $PRE_COMMIT_FILE ]; then
    echo "*** 7"
    npx husky add $PRE_COMMIT_FILE ""
  fi

  echo "*** 8"
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

  echo "*** 9"

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