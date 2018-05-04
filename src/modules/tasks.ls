require! {
  \../classes/tasks : Tasks
}

module.exports = (path = "#{process.env.HOME}/.tasks.json") -> Tasks.load path
