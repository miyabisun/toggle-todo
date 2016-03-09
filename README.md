# What this?

CLIのToDo管理ツールです

## Dependences
- [LiveScript](http://livescript.net/)
- [commander](https://www.npmjs.com/package/commander)
- [sqlite3](https://www.sqlite.org/index.html)
- [node-cli](https://github.com/miyabisun/node-cli)

# Installation

```bash
$ git clone https://github.com/m-ohata/todo.git
$ cd todo.git
$ npm install -g
```

# Usage

```bash
$ todo -h

  Usage: todo [options] [command]


  Commands:

    add|a [options] <names...>    Add task.
    end|e <ids...>                End task.
    list|ls [options]             Output task list.
    pause-all                     Pause all tasks.
    pause|p <ids...>              Pause task.
    refresh                       Refresh all tasks id.
    remove-all                    Remove todo-file at home directory.
    remove|rm [options] [ids...]  Remove task from list.
    rename|mv <id> <name>         Rename task.
    start|s <ids...>              Start task.

  Options:

    -h, --help     output usage information
    -V, --version  output the version number
```

