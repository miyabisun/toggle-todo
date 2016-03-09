CREATE TABLE todo(
  id INTEGER PRIMARY KEY,
  name TEXT,
  is_started INTEGER DEFAULT 0,
  is_ended INTEGER DEFAULT 0,
  created INTEGER,
  modified INTEGER
)

