require! \../classes/database.ls

module.exports = new database "#{process.env.HOME}/.todo"

