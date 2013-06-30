program = require("commander")

program
  .version("0.1.0")
  .usage("[options] <htmlfile ...>")
  .option("-o, --out <dir>", "output the compiled javascript to <dir>")
  .option("-a, --assign <to>", "what to assign compiled scripts to (default: window.compiledTemplates)")
  .option("-s, --selector <selector>", "jQuery selector for templates. (default: script[type='text/x-mustache-template'])")
  .parse(process.argv)

# console.log "program", program
options =
  dir: program.dir
  assignTo: program.to
  selector: program.selector

if program.args.length > 0
  mustachec = require("./mustachec")
  mustachec.compile program.args, options
else
  program.outputHelp()
