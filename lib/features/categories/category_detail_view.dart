import 'package:flutter/material.dart';
import '../../core/api/emoji_service.dart';
import '../../core/models/emoji_model.dart';

class CategoryDetailView extends StatefulWidget {
  final String category;

  const CategoryDetailView({super.key, required this.category});

  @override
  State<CategoryDetailView> createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends State<CategoryDetailView> {
  final EmojiService _service = EmojiService();
  List<Emoji> _emojis = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadEmojis();
  }

  Future<void> _loadEmojis() async {
    try {
      final emojis = await _service.getEmojisByCategory(widget.category);
      setState(() {
        _emojis = emojis;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  String _emojiFromUnicode(String unicode) {
    try {
      final code = int.parse(unicode.replaceAll('U+', ''), radix: 16);
      return String.fromCharCode(code);
    } catch (_) {
      return '?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: _emojis.length,
                  itemBuilder: (context, index) {
                    final emoji = _emojis[index];
                    final emojiChar = emoji.unicode.isNotEmpty
                        ? _emojiFromUnicode(emoji.unicode.first)
                        : '?';
                    return Tooltip(
                      message: emoji.name,
                      child: Center(
                        child: Text(
                          emojiChar,
                          style: const TextStyle(fontSize: 36),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
