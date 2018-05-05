#!/usr/bin/env node

const pkg = require('./package.json')
const commands = require('./dist/commands.json')
const program = require('caporal')

program.version(pkg.version)
commands.todo.subcommands.forEach(name => {
  const spec = commands[name]
  let prog = program.command(name, `${spec.alias ? `(${spec.alias}) ` : ''}${spec.desc}`)
  if (spec.alias)
    prog = prog.alias(spec.alias)
  if (spec.arguments)
    spec.arguments.forEach(([name, desc]) => prog = prog.argument(name, desc))
  if (spec.options)
    spec.options.forEach(([name, desc]) => prog = prog.option(name, desc))
  prog = prog.action(require(`./dist/commands/${name}`))
})

const argv = process.argv
if (process.argv.length < 3) process.argv.push('list')
program.parse(process.argv)
