FS = require("fs")
Path = require("path")

Cheerio = require("cheerio")
Hogan = require("hogan.js")

exports.compile = (args, options = {}) ->
  options.out = Path.join(process.cwd(), options.out) if options.out
  options.assign ?= "window.compiledTemplates"
  options.selector ?= "script[type='text/x-mustache-template']"
  for htmlFile in args
    html = FS.readFileSync htmlFile, encoding: "utf8"

    $ = Cheerio.load html
    $templates = $(options.selector)

    templates = {}
    $templates.each (index, element) ->
      $element = $(element)
      templates[$element.attr("id")] = Hogan.compile $element.text(), asString: true

    js = []
    js.push "#{options.assign} = {}"
    for own name, code of templates
      js.push "#{options.assign}[\"#{name}\"] = new Hogan.Template(#{code});"
    js = js.join("\n") + "\n"

    jsDir = options.out or Path.dirname(htmlFile)
    jsName = Path.basename(htmlFile, Path.extname(htmlFile))
    jsFile = Path.join(jsDir, jsName + "-templates.js")

    FS.writeFileSync jsFile, js
