import 'package:floor/floor.dart';

@entity
class Tags {
  @primaryKey
  final String id;

  final String tag;

  Tags(
    this.id,
    this.tag,
  );
}
