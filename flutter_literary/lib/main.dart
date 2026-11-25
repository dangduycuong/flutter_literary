import 'package:firebase_core/firebase_core.dart';
import 'package:material_ui/material_ui.dart';

import 'core/theme/font_scale_controller.dart';
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
    return ValueListenableBuilder<double>(
      valueListenable: FontScaleController.scalePercent,
      builder: (context, percent, _) {
        return MaterialApp(
          title: 'Văn Học Dân Gian',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorSchemeSeed: Colors.brown,
            useMaterial3: true,
            // Đặt toàn bộ cỡ chữ cơ bản về 14
            textTheme: const TextTheme(
              displayLarge: TextStyle(fontSize: 14),
              displayMedium: TextStyle(fontSize: 14),
              displaySmall: TextStyle(fontSize: 14),
              headlineLarge: TextStyle(fontSize: 14),
              headlineMedium: TextStyle(fontSize: 14),
              headlineSmall: TextStyle(fontSize: 14),
              titleLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              bodyLarge: TextStyle(fontSize: 14),
              bodyMedium: TextStyle(fontSize: 14),
              bodySmall: TextStyle(fontSize: 14),
              labelLarge: TextStyle(fontSize: 14),
              labelMedium: TextStyle(fontSize: 14),
              labelSmall: TextStyle(fontSize: 14),
            ),
          ),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(percent / 100.0)),
              child: child!,
            );
          },
          home: const MainScreen(),
        );
      },
    );
  }
}
