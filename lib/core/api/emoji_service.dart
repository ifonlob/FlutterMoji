import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/emoji_model.dart';

class EmojiService {
  static const String _baseUrl = 'https://emojihub.yurace.pro/api';

  Future<List<Emoji>> getAllEmojis() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/all'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Emoji.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar la lista de emojis');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/categories'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return List<String>.from(data);
      } else {
        throw Exception('Error al cargar las categorías');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<List<Emoji>> getEmojisByCategory(String category) async {
    final formattedCategory = category.replaceAll(' ', '-');
    try {
      final response = await http.get(Uri.parse('$_baseUrl/all/category/$formattedCategory'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Emoji.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar la categoría $category');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<Emoji> getRandomEmoji() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/random'));
      if (response.statusCode == 200) {
        return Emoji.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error al cargar un emoji aleatorio');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<List<Emoji>> searchEmojis(String query) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Emoji.fromJson(json)).toList();
      } else {
        throw Exception('Error en la búsqueda');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}