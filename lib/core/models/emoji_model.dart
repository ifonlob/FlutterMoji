class Emoji {
  final String name;
  final String category;
  final String group;
  final List<String> htmlCode;
  final List<String> unicode;

  Emoji({
    required this.name,
    required this.category,
    required this.group,
    required this.htmlCode,
    required this.unicode,
  });

  factory Emoji.fromJson(Map<String, dynamic> json) {
    return Emoji(
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      group: json['group'] ?? '',
      htmlCode: List<String>.from(json['htmlCode'] ?? []),
      unicode: List<String>.from(json['unicode'] ?? []),
    );
  }
}