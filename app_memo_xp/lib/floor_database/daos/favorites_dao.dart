import 'package:app_memo_xp/floor_database/entities/favorites.dart';
import 'package:floor/floor.dart';

@dao
abstract class FavoritesDao {
  @Query('SELECT * FROM Favorites')
  Future<List<Favorites>> findAllFavorites();

  @Query('SELECT * FROM Favorites WHERE id = :id')
  Stream<Favorites> findFavoritesById(String id);


  @insert
  Future<void> insertFavorites(Favorites favorite);

    @delete
  Future<void> deleteFavorite(Favorites favorite);

}
