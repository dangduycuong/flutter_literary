import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart'; // Đổi thành package:flutter/material.dart nếu SDK dùng bản cũ hơn 3.47

import '../../core/constants/literary_type.dart';
import '../../data/models/literary_item.dart';
import '../../data/repositories/literary_repository.dart';
import '../widgets/literary_card.dart';

class FavoritesPage extends StatelessWidget {
  final String uid;
  final LiteraryRepository repository;

  const FavoritesPage({super.key, required this.uid, required this.repository});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tủ Sách Yêu Thích'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Ca dao'),
              Tab(text: 'Tục ngữ'),
              Tab(text: 'Truyện ngắn'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildFavoriteList(LiteraryType.caDao),
            _buildFavoriteList(LiteraryType.tucNgu),
            _buildFavoriteList(LiteraryType.truyenNgan),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteList(String type) {
    return StreamBuilder<List<LiteraryItem>>(
      stream: repository.streamFavoritesByType(uid, type),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final items = snapshot.data ?? [];
        if (items.isEmpty) {
          return const Center(child: Text('Bạn chưa lưu mục nào ở phần này.'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return LiteraryCard(
              item: item,
              isFavorite: true,
              onToggleFavorite: () =>
                  repository.toggleFavorite(uid, item, true),
            );
          },
        );
      },
    );
  }
}
