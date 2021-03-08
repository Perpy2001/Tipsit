import 'package:app_memo_xp/floor_database/entities/pearson.dart';
import 'package:floor/floor.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM Person')
  Future<List<Person>> findAllPersons();

  @Query('SELECT * FROM Person WHERE id = :id')
  Stream<Person> findPersonById(String id);

  @Query('SELECT * FROM Person WHERE mail = :mail')
  Stream<Person> findPersonByMail(String mail);

  @Query('SELECT * FROM Person WHERE nome = :nome')
  Stream<Person> findPersonByNome(String nome);
  
  @insert
  Future<void> insertPerson(Person person);
}
