const readdirRecursive = require("recursive-readdir");
const { resolve, join } = require("path");
const util = require('util');
const exec = util.promisify(require('child_process').exec);

const handler = (err, stdout, stderr) => {
  if (err) {
    console.log(err)
    return;
  }
  console.log(stdout);
  console.log(stderr);
}

(async () => {
  let fileString = ''
  let lunaPath = resolve(join(__dirname, "..", "lunastream"));
  let lunaFiles = await readdirRecursive(lunaPath);
  for (const file of lunaFiles) {
    if (!file.includes("lunastream/main.lua"))
      fileString = file + " " + fileString
  }
  fileString = join(__dirname, "..", "lunastream", "main.lua") + " " + fileString
  const luastatic = "./lua_modules/bin/luastatic" 
  const lualib = "/usr/lib/x86_64-linux-gnu/liblua5.1.a"
  const luainclude = "-I/usr/include/lua5.1"
  const command = `${luastatic} ${fileString} ${lualib} ${luainclude}`
  await exec(command, handler);
})()