FS = require("fs")
Path = require("path")

Cheerio = require("cheerio")
Hogan = require("hogan.js")

exports.compile = (args, options = {}) ->
  assignTo = options.assignTo or "window.compiledTemplates"
  selector = options.selector or "script[type='text/x-mustache-template']"
  for htmlFile in args
    html = FS.readFileSync htmlFile, encoding: "utf8"

    $ = Cheerio.load html
    $templates = $(selector)

    templates = {}
    $templates.each (element) ->
      templates[@attr("id")] = Hogan.compile @text(), asString: true

    js = []
    js.push "#{assignTo} = {}"
    for own name, code of templates
      js.push "#{assignTo}[\"#{name}\"] = new Hogan.Template(#{code});"
    js = js.join("\n") + "\n"

    jsDir = options.dir or Path.dirname(htmlFile)
    jsName = Path.basename(htmlFile, Path.extname(htmlFile))
    jsFile = Path.join(jsDir, jsName + "-templates.js")

    FS.writeFileSync jsFile, js
