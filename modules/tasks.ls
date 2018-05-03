require! {
  \../classes/tasks.ls : Tasks
}

module.exports = (path = "#{__dirname}/../tmp/tasks.yml") -> Tasks.load path
