# relative-time :: TimeAgo -> DateTime -> String
module.exports = (time-ago, datetime) -->
  time-ago.format datetime.toJSDate!
