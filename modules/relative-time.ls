require! {
  \javascript-time-ago : TimeAgo
  \javascript-time-ago/locale/ja
  \../functions/relative-time.ls
}
TimeAgo.locale ja
module.exports = relative-time new TimeAgo \ja
