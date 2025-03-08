#!/bin/bash

# Get the directory of the binary
BIN_DIR="$(dirname "$0")"
REPOSITORY_NAME="@defi-wonderland/crypto-husky-checks"
HUSKY_DIR=".husky"
INSTALL_DIR_NAME="wonderland"
INSTALL_DIR="$HUSKY_DIR/$INSTALL_DIR_NAME"
PRE_COMMIT_FILE="$HUSKY_DIR/pre-commit"
SCRIPTS=("find-crypto-keys.sh")

if [[ "$OSTYPE" == darwin* ]]; then
  # MacOS path - don't append repository name as it's already in the path
  SCRIPT_DIR="$(cd "$BIN_DIR"; cd ..; pwd)/src"
elif [[ "$OSTYPE" == linux* ]]; then
  # Linux specific path - needs repository name
  SCRIPT_DIR="$(cd "$BIN_DIR"; cd ..; pwd)/$REPOSITORY_NAME/src"
elif [[ "$OSTYPE" == msys* || "$OSTYPE" == cygwin* ]]; then
  # Run script for Windows
  SCRIPT_DIR="$(cd "$BIN_DIR"; pwd)"
else
  echo "Unknown operating system"
  exit 1;
fi

install()
{
  # Check if husky is installed and set up
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
    echo "#!/bin/sh" > $PRE_COMMIT_FILE
    chmod +x $PRE_COMMIT_FILE
  fi

  for script in "${SCRIPTS[@]}"
  do
    # copy script to wonderland directory
    cp "$SCRIPT_DIR/$script" "$INSTALL_DIR/"

    # add script to pre-commit if needed
    if ! grep -q $script $PRE_COMMIT_FILE; then
      tee -a $PRE_COMMIT_FILE << EOF

. "\$(dirname "\$0")/wonderland/$script"
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
  if [[ "$OSTYPE" == darwin* ]]; then
    # MacOS requires an empty string argument for -i
    sed -i '' -e "/wonderland/d" $PRE_COMMIT_FILE
  else
    # Linux/Unix version - no -e flag needed
    sed -i "/\/$INSTALL_DIR_NAME\//d" $PRE_COMMIT_FILE
  fi

  echo "Wonderland Husky Checks uninstalled successfully"
}

case $1 in
  install)
    install
    ;;

  uninstall)
    uninstall
    ;;

  *)
    echo "Unrecognized command $1"
    ;;
esac