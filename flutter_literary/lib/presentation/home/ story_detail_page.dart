import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/models/literary_item.dart';

class StoryDetailPage extends StatelessWidget {
  final LiteraryItem item;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const StoryDetailPage({
    super.key,
    required this.item,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.category),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: onToggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Tác giả: ${item.author}',
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
            ),
            const Divider(height: 28),
            Text(
              item.content,
              style: const TextStyle(fontSize: 17, height: 1.7),
            ),
          ],
        ),
      ),
    );
  }
}
