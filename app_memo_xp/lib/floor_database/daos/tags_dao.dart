import 'package:floor/floor.dart';
import 'package:app_memo_xp/floor_database/entities/tags.dart';

@dao
abstract class TagsDao {
  @Query('SELECT * FROM Tags')
  Future<List<Tags>> findAllTags();
  
  @Query('SELECT * FROM Tags WHERE id = :id')
  Stream<Tags> findTagsById(String id);
  
  @insert
  Future<void> insertTags(Tags person);
}