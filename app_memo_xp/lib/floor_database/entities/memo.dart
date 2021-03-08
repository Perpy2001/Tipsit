import 'package:floor/floor.dart';

@entity
class Memo {
  @primaryKey
  final int id;

  final String mail;
  final String titolo;
  final String body;
  final String categoria;
  final String data;
  final String name;
  final String tags;

  Memo(this.id, this.name, this.titolo, this.body, this.categoria, this.data,
      this.mail, this.tags);
}
