require! {
  \../classes/tasks.ls : Tasks
}

module.exports = -> Tasks.load "#{__dirname}/../tmp/tasks.yml"
