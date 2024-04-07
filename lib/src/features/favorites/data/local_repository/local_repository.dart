import 'package:hive/hive.dart';
import 'package:pharmacy_hub/src/features/favorites/data/model/favorites_model.dart';

const String favoriteBoxName = 'favorite';

abstract class FavoriteLocalRepository {
  Future<List<FavoriteItem>> getFavorites();

  Future<int> addFavorite(FavoriteItem item);

  Future<void> removeFavorite(int index);

  Future<void> removeAllFavorite();

  Future<bool> isItemAdded(int id);

  Future<void> removeFavoriteItem(int id);
}

class FavoriteLocalRepositoryImpl extends FavoriteLocalRepository {
  final Box _box = Hive.box(favoriteBoxName);

  @override
  Future<int> addFavorite(FavoriteItem item) async {
    return await _box.add(item);
  }

  @override
  Future<List<FavoriteItem>> getFavorites() async {
    return _box.values.map((e) => FavoriteItem.fromEntity(e)).toList();
  }

  @override
  Future<bool> isItemAdded(int id) async {
    return (_box.values.toList().indexWhere((e) => e.id == id)) == -1
        ? false
        : true;
  }

  @override
  Future<void> removeAllFavorite() async {
    await _box.clear();
  }

  @override
  Future<void> removeFavorite(int index) async {
    await _box.deleteAt(index);
  }

  @override
  Future<void> removeFavoriteItem(int id) async {
    // Find the key for the item with the matching id
    var keyToDelete = _box.keys.firstWhere(
      (k) => _box.get(k).id == id,
      orElse: () => null,
    );
    // If a key was found, delete the item from the box
    if (keyToDelete != null) {
      await _box.delete(keyToDelete);
    }
  }
}
