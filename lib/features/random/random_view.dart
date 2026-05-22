import 'package:flutter/material.dart';
import '../../core/api/emoji_service.dart';
import '../../core/models/emoji_model.dart';
import 'services/favorite_service.dart';

class RandomView extends StatefulWidget {
  const RandomView({super.key});

  @override
  State<RandomView> createState() => _RandomViewState();
}

class _RandomViewState extends State<RandomView> {
  final EmojiService _emojiService = EmojiService();
  final FavoritesService _favoritesService = FavoritesService();

  Emoji? _currentEmoji;
  bool _isLoading = true;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _fetchNewRandomEmoji();
  }

  Future<void> _fetchNewRandomEmoji() async {
    setState(() => _isLoading = true);
    try {
      final emoji = await _emojiService.getRandomEmoji();
      final isFav = await _favoritesService.isFavorite(emoji.name);
      
      setState(() {
        _currentEmoji = emoji;
        _isFavorite = isFav;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleFavorite() async {
    if (_currentEmoji == null) return;

    if (_isFavorite) {
      await _favoritesService.removeFavorite(_currentEmoji!.name);
    } else {
      await _favoritesService.addFavorite(_currentEmoji!.name);
    }

    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  String _parseUnicode(List<String> unicodeList) {
    if (unicodeList.isEmpty) return '❓';
    try {
      String hexString = unicodeList.first.replaceAll('U+', '');
      int codePoint = int.parse(hexString, radix: 16);
      return String.fromCharCode(codePoint);
    } catch (e) {
      return '❓';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.black)
            : _currentEmoji == null
                ? const Text('Error al cargar el emoji')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _parseUnicode(_currentEmoji!.unicode),
                        style: const TextStyle(fontSize: 120),
                      ),
                      const SizedBox(height: 20),
                      
                      Text(
                        _currentEmoji!.name.toUpperCase(),
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      
                      Text(
                        _currentEmoji!.category,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                      const SizedBox(height: 40),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 40,
                            icon: Icon(
                              _isFavorite ? Icons.star : Icons.star_border,
                              color: _isFavorite ? Colors.black : Colors.grey,
                            ),
                            onPressed: _toggleFavorite,
                          ),
                          const SizedBox(width: 30),
                          
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            icon: const Icon(Icons.shuffle),
                            label: const Text('OTRO MÁS', 
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: _fetchNewRandomEmoji,
                          ),
                        ],
                      )
                    ],
                  ),
      ),
    );
  }
}