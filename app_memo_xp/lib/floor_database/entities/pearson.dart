import 'package:floor/floor.dart';

@entity
class Person {
  @primaryKey
  final String id;

  final String nome;
  final String mail;
  final String tel;

  Person(
    this.id,
    this.nome,
    this.mail,
    this.tel,
  );
}
