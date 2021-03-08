// database.dart

// required package imports
import 'dart:async';
import 'package:app_memo_xp/floor_database/entities/pearson.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'daos/memo_dao.dart';
import 'daos/tags_dao.dart';
import 'daos/pearson_dao.dart';
import 'entities/memo.dart';
import 'entities/tags.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Person, Memo, Tags])
abstract class AppDatabase extends FloorDatabase {
  PersonDao get personDao;
  MemoDao get memoDao;
  TagsDao get tagsDao;
}
