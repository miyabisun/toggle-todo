require! <[moment]>

module.exports = ({log, database})-> ->
  err, rows <- database.db.all """
    SELECT *
    FROM todo
    WHERE is_started = 1 AND is_ended = 0
    ORDER BY modified ASC
  """
  if rows.length
    log.output rows.0.name
  else
    err, rows <- database.db.all """
      SELECT *
      FROM todo
      WHERE is_started = 0 AND is_ended = 0
      ORDER BY modified ASC
    """
    log.output rows.0.name

