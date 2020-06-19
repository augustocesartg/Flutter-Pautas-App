final List<String> initialScript = [
  '''
    CREATE TABLE user_model (
      id           INTEGER PRIMARY KEY,
      name         TEXT    NOT NULL,
      email        TEXT    NOT NULL,
      password     TEXT    NOT NULL
     )
  ''',
  '''
    CREATE TABLE guideline_model (
      id           INTEGER PRIMARY KEY,
      title        TEXT    NOT NULL,
      description  TEXT    NOT NULL,
      details      TEXT    NOT NULL,
      author       TEXT    NOT NULL,
      userId       INTEGER NOT NULL,
      status       INTEGER NOT NULL
     )
  ''',
];
