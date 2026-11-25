import 'package:material_ui/material_ui.dart';

class FontScaleController {
  // Mặc định 100% (tương đương cỡ chữ 14)
  static final ValueNotifier<double> scalePercent = ValueNotifier<double>(
    100.0,
  );

  static const double minPercent = 80.0;
  static const double maxPercent = 150.0;
  static const double step = 5.0;

  static void increase() {
    if (scalePercent.value < maxPercent) {
      scalePercent.value = (scalePercent.value + step).clamp(
        minPercent,
        maxPercent,
      );
    }
  }

  static void decrease() {
    if (scalePercent.value > minPercent) {
      scalePercent.value = (scalePercent.value - step).clamp(
        minPercent,
        maxPercent,
      );
    }
  }

  static void reset() {
    scalePercent.value = 100.0;
  }
}

/// Cụm nút A- / 100% / A+ để gắn vào góc phải AppBar
class FontScaleActions extends StatelessWidget {
  const FontScaleActions({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: FontScaleController.scalePercent,
      builder: (context, percent, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Giảm cỡ chữ',
              onPressed: percent > FontScaleController.minPercent
                  ? FontScaleController.decrease
                  : null,
              icon: const Text(
                'A-',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: FontScaleController.reset,
              child: Tooltip(
                message: 'Chạm để đặt lại 100%',
                child: Text(
                  '${percent.round()}%',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            IconButton(
              tooltip: 'Tăng cỡ chữ',
              onPressed: percent < FontScaleController.maxPercent
                  ? FontScaleController.increase
                  : null,
              icon: const Text(
                'A+',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 4),
          ],
        );
      },
    );
  }
}
