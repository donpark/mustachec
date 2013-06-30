Compiles Mustache templates in HTML to javascript.

Compiled templates don't use `eval` nor `Function` so they can
be used from restricted environments such as Chrome extension
apps.

## Status

Tests TBD

## Install

    npm install mustachec

## Usage

### Compiling

    mustachec main.html

compiles each Mustache template within `main.html` like below

    script#dialog-template(type='text/x-mustache-template')
      .modal.hide
        .modal-header
          a.cancel.close &times;
          img.modal-logo(src='/img/brand.png')
          .modal-title {{title}}

    script#confirm-dialog-subtemplate(type='text/x-mustache-template')
      .modal-body
        center {{message}}
      .modal-footer
        button.cancel.btn Cancel
        button.ok.btn.btn-primary {{confirm}}

into javascript and save them as `main-templates.js` file like below
in the same directory:

    window.compiledTemplates = {}
    window.compiledTemplates["dialog-template"] = ...;
    window.compiledTemplates["confirm-dialog-subtemplate"] = ...;

### Rendering

    var context = { title: "foobar" };
    var renderedHtml = window.compiledTemplates["dialog-template"].render(context)

### Options

Use `-s` or `--selector` option to override jQuery selector used to identify Mustache template elements in HTML input. Default selector is `script[type='text/x-mustache-template']` like this:

    mustachec -s ".template" main.html

Use `-a` or `--assign` option to specify where to store the compiled templates.
Default location is `window.compiledTemplates`.

    mustachec -a "var compiledTemplates" main.html

Use `-o` or `--out` option to specify output directory.

    mustachec -o ../build main.html

