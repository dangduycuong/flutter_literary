import 'package:material_ui/material_ui.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: Colors.brown,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(
        0xFFFAF8F5,
      ), // Màu nền giấy đọc sách dịu mắt
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Color(0xFFFAF8F5),
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
