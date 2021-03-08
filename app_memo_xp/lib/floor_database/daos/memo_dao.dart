import 'package:app_memo_xp/floor_database/entities/memo.dart';
import 'package:floor/floor.dart';

@dao
abstract class MemoDao {
  @Query('SELECT * FROM Memo')
  Future<List<Memo>> findAllMemo();
  
  @Query('SELECT * FROM Memo WHERE id = :id')
  Stream<Memo> findMemoById(String id);

    @Query('SELECT * FROM Memo WHERE mail = :mail')
  Stream<Memo> findMemoByMail(String id);
  
      @Query('SELECT * FROM Memo WHERE tag = :tag')
  Stream<Memo> findMemoByTag(String id);
  
      @Query('SELECT * FROM Memo WHERE titolo = :titolo')
  Stream<Memo> findMemoByTitolo(String id);

  @insert
  Future<void> insertMemo(Memo person);
}