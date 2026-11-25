import 'package:flutter/widgets.dart';
import 'package:flutter_literary/core/theme/font_scale_controller.dart';
import 'package:material_ui/material_ui.dart'; // Đổi thành package:flutter/material.dart nếu SDK của bạn dùng bản cũ

import '../../data/models/literary_item.dart';
import '../../data/repositories/literary_repository.dart';
import '../widgets/literary_card.dart';

class LiteraryListPage extends StatefulWidget {
  final String type;
  final String title;
  final String uid;
  final LiteraryRepository repository;

  const LiteraryListPage({
    super.key,
    required this.type,
    required this.title,
    required this.uid,
    required this.repository,
  });

  @override
  State<LiteraryListPage> createState() => _LiteraryListPageState();
}

class _LiteraryListPageState extends State<LiteraryListPage> {
  String _selectedCategory = 'Tất cả';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: const [FontScaleActions()],
      ),
      body: StreamBuilder<Set<String>>(
        stream: widget.repository.streamFavoriteIds(widget.uid),
        builder: (context, favSnap) {
          final favIds = favSnap.data ?? {};

          return StreamBuilder<List<LiteraryItem>>(
            stream: widget.repository.streamItemsByType(widget.type),
            builder: (context, itemSnap) {
              if (itemSnap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final allItems = itemSnap.data ?? [];
              if (allItems.isEmpty) {
                return const Center(
                  child: Text('Chưa có dữ liệu cho mục này.'),
                );
              }

              // Tự động gom các chủ đề hiện có để tạo thanh lọc ngang
              final categories = [
                'Tất cả',
                ...allItems.map((e) => e.category).toSet(),
              ];

              final filteredItems = _selectedCategory == 'Tất cả'
                  ? allItems
                  : allItems
                        .where((e) => e.category == _selectedCategory)
                        .toList();

              return Column(
                children: [
                  // Thanh lọc chủ đề ngang
                  SizedBox(
                    height: 50,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        return ChoiceChip(
                          label: Text(cat),
                          selected: _selectedCategory == cat,
                          onSelected: (_) =>
                              setState(() => _selectedCategory = cat),
                        );
                      },
                    ),
                  ),
                  // Danh sách nội dung
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        final isFav = favIds.contains(item.id);
                        return LiteraryCard(
                          item: item,
                          isFavorite: isFav,
                          onToggleFavorite: () => widget.repository
                              .toggleFavorite(widget.uid, item, isFav),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
