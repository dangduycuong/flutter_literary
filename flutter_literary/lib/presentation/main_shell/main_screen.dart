import 'package:material_ui/material_ui.dart'; // Hoặc package:flutter/material.dart tùy SDK của bạn

import '../../core/constants/literary_type.dart';
import '../../data/repositories/literary_repository.dart';
import '../favorites/favorites_page.dart';
import '../home/literary_list_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final LiteraryRepository _repository = LiteraryRepository();
  int _currentIndex = 0;
  String? _uid;

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  Future<void> _initUser() async {
    final uid = await _repository.ensureUser();
    if (mounted) {
      setState(() => _uid = uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_uid == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final pages = [
      LiteraryListPage(
        type: LiteraryType.caDao,
        title: 'Ca Dao Việt Nam',
        uid: _uid!,
        repository: _repository,
      ),
      LiteraryListPage(
        type: LiteraryType.tucNgu,
        title: 'Tục Ngữ Việt Nam',
        uid: _uid!,
        repository: _repository,
      ),
      LiteraryListPage(
        type: LiteraryType.truyenNgan,
        title: 'Truyện Ngắn Hay',
        uid: _uid!,
        repository: _repository,
      ),
      FavoritesPage(uid: _uid!, repository: _repository),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.auto_stories_outlined),
            selectedIcon: Icon(Icons.auto_stories),
            label: 'Ca dao',
          ),
          NavigationDestination(
            icon: Icon(Icons.lightbulb_outline),
            selectedIcon: Icon(Icons.lightbulb),
            label: 'Tục ngữ',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Truyện ngắn',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Yêu thích',
          ),
        ],
      ),
    );
  }
}
