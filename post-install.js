// "postinstall": "cp -r src $INIT_CWD/.github/.husky/wonderland"

/**
 * Script to run after npm install
 *
 * Copy selected files to user's directory
 */

const fs = require('fs-extra');

const COLOR_RESET = '\x1b[0m';
const COLOR_RED = '\x1b[31m';
const COLOR_GREEN = '\x1b[32m';
const COLOR_BLUE = '\x1b[34m';

const HUSKY_PATH = '.husky/wonderland/';
const SRC_DIR = `src`;
const DEST_DIR = `${process.env.INIT_CWD}/${HUSKY_PATH}`;
                                 
// To copy a folder or file, select overwrite accordingly
try {
  fs.copySync(SRC_DIR, DEST_DIR, { overwrite: true });
  console.log(`${COLOR_GREEN}Wonderland checks successfully copied to ${COLOR_BLUE}${HUSKY_PATH}${COLOR_RESET}`);
} catch (err) {
  console.error(`${COLOR_RED}${err}${COLOR_RESET}`);
}