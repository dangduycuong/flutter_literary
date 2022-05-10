import 'package:flutter/material.dart';
import 'package:flutter_literary/presentation/bottom_navigation_bar/ui/bottom_navigation_bar.dart';
import 'package:flutter_literary/ui/csv_to_list.dart';
import 'package:flutter_literary/ui/display_content.dart';
import 'package:flutter_literary/ui/example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'PlayfairDisplay',
        primarySwatch: Colors.blue,
      ),
      // home: const HomePageScreen(),
      home: const BottomNavigationBarHome(),
    );
  }
}
