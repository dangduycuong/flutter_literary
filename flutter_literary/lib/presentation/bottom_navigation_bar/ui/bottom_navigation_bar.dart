import 'package:flutter/material.dart';
import 'package:flutter_literary/presentation/common/title_app_bar.dart';
import '../../Idioms_categories/ui/Idioms_categories_page.dart';
import '../../folk_verses_categories/ui/folk_verses_categories_page.dart';
import '../../proverb_categories/ui/proverb_categories_page.dart';

class BottomNavigationBarHome extends StatefulWidget {
  const BottomNavigationBarHome({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarHome> createState() =>
      _BottomNavigationBarHomeState();
}

class _BottomNavigationBarHomeState extends State<BottomNavigationBarHome> {
  int _selectedIndex = 0;

  String get _titleAppBar {
    String result = '';
    switch (_selectedIndex) {
      case 0:
        result = 'Ca Dao';
        break;
      case 1:
        result = 'Tục Ngữ';
        break;
      case 2:
        result = 'Thành Ngữ';
        break;
      default:
        result = 'Feature';
        break;
    }
    return result;
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    FolkVersesCategoriesPage(),
    ProverbCategoriesPage(),
    IdiomsCategoriesPage(),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: titleAppBar(_titleAppBar),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Ca Dao',
              // backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Tục Ngữ',
              // backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Thành Ngữ',
                // backgroundColor: Colors.purple,
                tooltip: 'To Mõm'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              // backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.indigoAccent,
          onTap: _onItemTapped,
          showUnselectedLabels: true,
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
