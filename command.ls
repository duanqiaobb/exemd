
{docopt}             = require('docopt')
_                    = require('lodash')
{cat,mkdir,rm, exec} = require('shelljs')
v                    = require('verbal-expressions')
uid                  = require('uid')
Promise              = require('bluebird')
asyncrepl            = require('async-replace')
{process} = require('./index')

#module-path = "/usr/local/share/npm/lib/node_modules/"
module-path = ""

require! 'fs'

doc = """
Usage:
    exemd FILE [ -r | --raw ] [ -g | --force-png ] [ -p | --pdf ]
    exemd -h | --help

Options:
    -g, --force-png     Generate html+png(inline). Default is html+svg(inline).
    -r, --raw           Generate md+png(inline).
    -p, --pdf           Generate md+pdf(external). Output can be used by pandoc to generate pdf docs.
    -h, --help

Arguments:
    FILE       markdown file name.


"""



get-option = (a, b, def, o) ->
    if not o[a] and not o[b]
        return def
    else
        return o[b]

o = docopt(doc)

if o['-g'] or o['--force-png']
    target-mode = 'html,png'
else
    if o['--raw'] or o['-r']
        target-mode = 'raw,png'
    else
        if o['-p'] or o['--pdf']
            target-mode = 'raw,pdf'
        else
            target-mode = 'html'

FILE = o['FILE']


text = cat(FILE)

process(target-mode, text).then ->
    console.log it
