import 'package:flutter/material.dart';
import 'package:emojihub_app/core/models/emoji_model.dart';

class EmojiCard extends StatelessWidget {
  final Emoji emoji;
  final VoidCallback? onTap;

  const EmojiCard({
    super.key,
    required this.emoji,
    this.onTap,
  });

  // Función traductora: Convierte "U+1F600" a "😀"
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
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface, 
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _parseUnicode(emoji.unicode),
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 8),
            Text(
              emoji.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}