# What this?

CLIのToDo管理ツールです

## Dependences

- [LiveScript](http://livescript.net/)
- [caporal](https://www.npmjs.com/package/caporal)

# Installation

インストールにはNode.jsが必要です。

```bash
$ node -v
v9.10.1

$ npm install -g github:miyabisun/todo-cli
```

# Usage

```bash
$ todo -h

   todo 0.2.0

   USAGE

     todo <command> [options]

   COMMANDS

     list                    (ls) Output task list.
     add <names...>          (a) Add task.
     end <ids...>            (e) End task.
     next                    Output task of ones.
     pause [ids...]          (p) Pause task.
     refresh                 Refresh all tasks id.
     remove-all              Remove todo-file at home directory.
     remove [ids...]         (rm) Remove task from list.
     rename <id> <name>      (mv) Rename task.
     start <ids...>          (s) Start task.
     help <command>          Display help for a specific command

   GLOBAL OPTIONS

     -h, --help         Display help
     -V, --version      Display version
     --no-color         Disable colors
     --quiet            Quiet mode - only displays warn and error messages
     -v, --verbose      Verbose mode - will also output debug messages
```

