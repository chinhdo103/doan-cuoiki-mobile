class TranslationHistory {
  final int id;
  final String originalText;
  final String translatedText;
  final DateTime timestamp;

  TranslationHistory({
    required this.id,
    required this.originalText,
    required this.translatedText,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'original_text': originalText,
      'translated_text': translatedText,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
