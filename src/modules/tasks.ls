require! {
  \../classes/tasks.ls : Tasks
}

module.exports = (path = "#{process.env.HOME}/tasks.yml") -> Tasks.load path
