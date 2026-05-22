import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorite_emojis_list';

  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  Future<void> addFavorite(String emojiName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> currentFavorites = prefs.getStringList(_favoritesKey) ?? [];
    
    if (!currentFavorites.contains(emojiName)) {
      currentFavorites.add(emojiName);
      await prefs.setStringList(_favoritesKey, currentFavorites);
    }
  }

  Future<void> removeFavorite(String emojiName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> currentFavorites = prefs.getStringList(_favoritesKey) ?? [];
    
    if (currentFavorites.contains(emojiName)) {
      currentFavorites.remove(emojiName);
      await prefs.setStringList(_favoritesKey, currentFavorites);
    }
  }

  // Comprobar si un emoji específico ya es favorito
  Future<bool> isFavorite(String emojiName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> currentFavorites = prefs.getStringList(_favoritesKey) ?? [];
    return currentFavorites.contains(emojiName);
  }
}