import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A checkerboard pattern widget used as the preview background in the
/// Background Remover screen.
///
/// Draws a checkerboard of [cellSize] squares alternating between
/// [colorA] and [colorB].
class CheckerboardBackground extends StatelessWidget {
  const CheckerboardBackground({
    super.key,
    this.cellSize = 12.0,
    this.colorA = const Color(0xFFE8E8E8),
    this.colorB = Colors.white,
    this.child,
  });

  final double cellSize;
  final Color colorA;
  final Color colorB;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.base),
      child: CustomPaint(
        painter: _CheckerboardPainter(
          cellSize: cellSize,
          colorA: colorA,
          colorB: colorB,
        ),
        child: child,
      ),
    );
  }
}

class _CheckerboardPainter extends CustomPainter {
  _CheckerboardPainter({
    required this.cellSize,
    required this.colorA,
    required this.colorB,
  });

  final double cellSize;
  final Color colorA;
  final Color colorB;

  @override
  void paint(Canvas canvas, Size size) {
    final paintA = Paint()..color = colorA;
    final paintB = Paint()..color = colorB;

    final cols = (size.width / cellSize).ceil();
    final rows = (size.height / cellSize).ceil();

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final paint = (row + col) % 2 == 0 ? paintA : paintB;
        canvas.drawRect(
          Rect.fromLTWH(
            col * cellSize,
            row * cellSize,
            cellSize,
            cellSize,
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CheckerboardPainter oldDelegate) =>
      cellSize != oldDelegate.cellSize ||
      colorA != oldDelegate.colorA ||
      colorB != oldDelegate.colorB;
}
