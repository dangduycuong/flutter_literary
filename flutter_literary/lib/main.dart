import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_literary/core/theme/app_theme.dart';
import 'package:material_ui/material_ui.dart'; // Giữ nguyên dòng import UI hiện tại của file main.dart

import 'firebase_options.dart';
import 'presentation/main_shell/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Văn Học Dân Gian',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainScreen(),
    );
  }
}
