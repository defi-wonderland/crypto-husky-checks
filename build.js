/**
 * Script to build files
 *
 * Copy build files to /dist directory
 */

const fs = require('fs-extra');

const COLOR_RESET = '\x1b[0m';
const COLOR_RED = '\x1b[31m';
const COLOR_GREEN = '\x1b[32m';

const FILES = [
  'LICENSE', 
  'package.json', 
  'post-install.js', 
  'README.md'
];
const FOLDERS = ['src'];
const DIST_DIR = `dist`;
                               
try {
  fs.removeSync(DIST_DIR);
  fs.mkdirSync(DIST_DIR);

  FILES.forEach(file => {
    fs.copyFileSync(file, `${DIST_DIR}/${file}`);
  })
  FOLDERS.forEach(folder => {
    fs.copySync(folder, `${DIST_DIR}/${folder}`);
  })
  console.log(`${COLOR_GREEN}Build successful${COLOR_RESET}`);
} catch (err) {
  console.error(`${COLOR_RED}${err}${COLOR_RESET}`);
}