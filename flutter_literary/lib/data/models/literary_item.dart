import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constants/literary_type.dart';

class LiteraryItem {
  final String id;
  final String type;
  final String category;
  final String title;
  final String content;
  final String author;

  const LiteraryItem({
    required this.id,
    required this.type,
    required this.category,
    required this.title,
    required this.content,
    required this.author,
  });

  factory LiteraryItem.fromMap(String id, Map<String, dynamic> map) {
    return LiteraryItem(
      id: id,
      type: map['type'] ?? LiteraryType.caDao,
      category: map['category'] ?? 'Khác',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      author: map['author'] ?? 'Dân gian',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'category': category,
      'title': title,
      'content': content,
      'author': author,
      'savedAt': FieldValue.serverTimestamp(),
    };
  }
}
