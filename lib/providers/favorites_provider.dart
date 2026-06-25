import 'package:flutter/foundation.dart';
import '../models/attraction.dart';
import '../services/db_service.dart';

class FavoritesProvider with ChangeNotifier {
  List<Attraction> _favorites = [];

  List<Attraction> get favorites => _favorites;

  Future<void> init() async {
    _favorites = await DbService.getFavorites();
    notifyListeners();
  }

  bool isFavorite(String id) {
    return _favorites.any((a) => a.id == id);
  }

  Future<void> toggleFavorite(Attraction attraction) async {
    if (isFavorite(attraction.id)) {
      await DbService.deleteFavorite(attraction.id);
      _favorites.removeWhere((a) => a.id == attraction.id);
    } else {
      await DbService.insertFavorite(attraction);
      _favorites.add(attraction);
    }
    notifyListeners();
  }
}