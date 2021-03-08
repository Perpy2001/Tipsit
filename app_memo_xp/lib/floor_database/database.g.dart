// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PersonDao _personDaoInstance;

  MemoDao _memoDaoInstance;

  TagsDao _tagsDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Person` (`id` TEXT, `nome` TEXT, `mail` TEXT, `tel` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Memo` (`id` INTEGER, `mail` TEXT, `titolo` TEXT, `body` TEXT, `categoria` TEXT, `data` TEXT, `name` TEXT, `tags` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Tags` (`id` TEXT, `tag` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PersonDao get personDao {
    return _personDaoInstance ??= _$PersonDao(database, changeListener);
  }

  @override
  MemoDao get memoDao {
    return _memoDaoInstance ??= _$MemoDao(database, changeListener);
  }

  @override
  TagsDao get tagsDao {
    return _tagsDaoInstance ??= _$TagsDao(database, changeListener);
  }
}

class _$PersonDao extends PersonDao {
  _$PersonDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _personInsertionAdapter = InsertionAdapter(
            database,
            'Person',
            (Person item) => <String, dynamic>{
                  'id': item.id,
                  'nome': item.nome,
                  'mail': item.mail,
                  'tel': item.tel
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Person> _personInsertionAdapter;

  @override
  Future<List<Person>> findAllPersons() async {
    return _queryAdapter.queryList('SELECT * FROM Person',
        mapper: (Map<String, dynamic> row) => Person(
            row['id'] as String,
            row['nome'] as String,
            row['mail'] as String,
            row['tel'] as String));
  }

  @override
  Stream<Person> findPersonById(String id) {
    return _queryAdapter.queryStream('SELECT * FROM Person WHERE id = ?',
        arguments: <dynamic>[id],
        queryableName: 'Person',
        isView: false,
        mapper: (Map<String, dynamic> row) => Person(
            row['id'] as String,
            row['nome'] as String,
            row['mail'] as String,
            row['tel'] as String));
  }

  @override
  Stream<Person> findPersonByMail(String mail) {
    return _queryAdapter.queryStream('SELECT * FROM Person WHERE mail = ?',
        arguments: <dynamic>[mail],
        queryableName: 'Person',
        isView: false,
        mapper: (Map<String, dynamic> row) => Person(
            row['id'] as String,
            row['nome'] as String,
            row['mail'] as String,
            row['tel'] as String));
  }

  @override
  Stream<Person> findPersonByNome(String nome) {
    return _queryAdapter.queryStream('SELECT * FROM Person WHERE nome = ?',
        arguments: <dynamic>[nome],
        queryableName: 'Person',
        isView: false,
        mapper: (Map<String, dynamic> row) => Person(
            row['id'] as String,
            row['nome'] as String,
            row['mail'] as String,
            row['tel'] as String));
  }

  @override
  Future<void> insertPerson(Person person) async {
    await _personInsertionAdapter.insert(person, OnConflictStrategy.abort);
  }
}

class _$MemoDao extends MemoDao {
  _$MemoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _memoInsertionAdapter = InsertionAdapter(
            database,
            'Memo',
            (Memo item) => <String, dynamic>{
                  'id': item.id,
                  'mail': item.mail,
                  'titolo': item.titolo,
                  'body': item.body,
                  'categoria': item.categoria,
                  'data': item.data,
                  'name': item.name,
                  'tags': item.tags
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Memo> _memoInsertionAdapter;

  @override
  Future<List<Memo>> findAllMemo() async {
    return _queryAdapter.queryList('SELECT * FROM Memo',
        mapper: (Map<String, dynamic> row) => Memo(
            row['id'] as int,
            row['name'] as String,
            row['titolo'] as String,
            row['body'] as String,
            row['categoria'] as String,
            row['data'] as String,
            row['mail'] as String,
            row['tags'] as String));
  }

  @override
  Stream<Memo> findMemoById(String id) {
    return _queryAdapter.queryStream('SELECT * FROM Memo WHERE id = ?',
        arguments: <dynamic>[id],
        queryableName: 'Memo',
        isView: false,
        mapper: (Map<String, dynamic> row) => Memo(
            row['id'] as int,
            row['name'] as String,
            row['titolo'] as String,
            row['body'] as String,
            row['categoria'] as String,
            row['data'] as String,
            row['mail'] as String,
            row['tags'] as String));
  }

  @override
  Stream<Memo> findMemoByMail(String id) {
    return _queryAdapter.queryStream('SELECT * FROM Memo WHERE mail = ?',
        arguments: <dynamic>[id],
        queryableName: 'Memo',
        isView: false,
        mapper: (Map<String, dynamic> row) => Memo(
            row['id'] as int,
            row['name'] as String,
            row['titolo'] as String,
            row['body'] as String,
            row['categoria'] as String,
            row['data'] as String,
            row['mail'] as String,
            row['tags'] as String));
  }

  @override
  Stream<Memo> findMemoByTag(String id) {
    return _queryAdapter.queryStream('SELECT * FROM Memo WHERE tag = ?',
        arguments: <dynamic>[id],
        queryableName: 'Memo',
        isView: false,
        mapper: (Map<String, dynamic> row) => Memo(
            row['id'] as int,
            row['name'] as String,
            row['titolo'] as String,
            row['body'] as String,
            row['categoria'] as String,
            row['data'] as String,
            row['mail'] as String,
            row['tags'] as String));
  }

  @override
  Stream<Memo> findMemoByTitolo(String id) {
    return _queryAdapter.queryStream('SELECT * FROM Memo WHERE titolo = ?',
        arguments: <dynamic>[id],
        queryableName: 'Memo',
        isView: false,
        mapper: (Map<String, dynamic> row) => Memo(
            row['id'] as int,
            row['name'] as String,
            row['titolo'] as String,
            row['body'] as String,
            row['categoria'] as String,
            row['data'] as String,
            row['mail'] as String,
            row['tags'] as String));
  }

  @override
  Future<void> insertMemo(Memo person) async {
    await _memoInsertionAdapter.insert(person, OnConflictStrategy.abort);
  }
}

class _$TagsDao extends TagsDao {
  _$TagsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _tagsInsertionAdapter = InsertionAdapter(
            database,
            'Tags',
            (Tags item) => <String, dynamic>{'id': item.id, 'tag': item.tag},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Tags> _tagsInsertionAdapter;

  @override
  Future<List<Tags>> findAllTags() async {
    return _queryAdapter.queryList('SELECT * FROM Tags',
        mapper: (Map<String, dynamic> row) =>
            Tags(row['id'] as String, row['tag'] as String));
  }

  @override
  Stream<Tags> findTagsById(String id) {
    return _queryAdapter.queryStream('SELECT * FROM Tags WHERE id = ?',
        arguments: <dynamic>[id],
        queryableName: 'Tags',
        isView: false,
        mapper: (Map<String, dynamic> row) =>
            Tags(row['id'] as String, row['tag'] as String));
  }

  @override
  Future<void> insertTags(Tags person) async {
    await _tagsInsertionAdapter.insert(person, OnConflictStrategy.abort);
  }
}
