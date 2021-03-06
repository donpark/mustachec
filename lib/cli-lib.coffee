program = require("commander")

program
  .version("0.1.3")
  .usage("[options] <htmlfile ...>")
  .option("-o, --out <dir>", "output the compiled javascript to <dir>")
  .option("-a, --assign <to>", "what to assign compiled scripts to (default: window.compiledTemplates)")
  .option("-s, --selector <selector>", "jQuery selector for templates. (default: script[type='text/x-mustache-template'])")
  .parse(process.argv)

if program.args.length > 0
  # console.log "program", program
  options =
    out: program.out
    assign: program.assign
    selector: program.selector
  # console.log "options", options
  mustachec = require("./mustachec")
  mustachec.compile program.args, options
else
  program.outputHelp()
