import 'package:flutter/widgets.dart';
import 'package:flutter_literary/presentation/home/%20story_detail_page.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/constants/literary_type.dart';
import '../../data/models/literary_item.dart';

class LiteraryCard extends StatelessWidget {
  final LiteraryItem item;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const LiteraryCard({
    super.key,
    required this.item,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final isStory = item.type == LiteraryType.truyenNgan;

    return Card(
      elevation: 0.5,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.brown.withValues(alpha: 0.15)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: isStory
            ? () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StoryDetailPage(
                    item: item,
                    isFavorite: isFavorite,
                    onToggleFavorite: onToggleFavorite,
                  ),
                ),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(
                      item.category,
                      style: const TextStyle(fontSize: 12),
                    ),
                    visualDensity: VisualDensity.compact,
                    side: BorderSide.none,
                    backgroundColor: Colors.brown.withValues(alpha: 0.08),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: onToggleFavorite,
                  ),
                ],
              ),
              if (item.title.isNotEmpty) ...[
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
              ],
              Text(
                item.content,
                maxLines: isStory ? 4 : null,
                overflow: isStory ? TextOverflow.ellipsis : null,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              if (isStory) ...[
                const SizedBox(height: 10),
                Text(
                  'Bấm để đọc toàn bộ truyện • ${item.author}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
