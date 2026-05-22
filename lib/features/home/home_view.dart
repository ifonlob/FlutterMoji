import 'package:flutter/material.dart';
import '../../core/api/emoji_service.dart';
import '../../core/models/emoji_model.dart';
import 'widgets/emoji_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final EmojiService _emojiService = EmojiService();
  late Future<List<Emoji>> _emojisFuture;

  @override
  void initState() {
    super.initState();
    _emojisFuture = _emojiService.getAllEmojis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'EmojiHub',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<Emoji>>(
        future: _emojisFuture,
        builder: (context, snapshot) {
          // 1. Estado de carga
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.black87,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('😢', style: TextStyle(fontSize: 48)),
                    const SizedBox(height: 16),
                    Text(
                      'No pudimos cargar los emojis',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _emojisFuture = _emojiService.getAllEmojis();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            );
          }

          final emojis = snapshot.data ?? [];

          if (emojis.isEmpty) {
            return const Center(
              child: Text('No hay emojis disponibles en este momento.'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: emojis.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) {
              return EmojiCard(emoji: emojis[index]);
            },
          );
        },
      ),
    );
  }
}