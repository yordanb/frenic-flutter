import "dart:math";
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class VfdGaugeCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final double gaugeValue;
  final String subtitle;

  const VfdGaugeCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.gaugeValue,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[400],
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: gaugeValue),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return CustomPaint(
                    size: const Size(double.infinity, 80),
                    painter: _GaugePainter(
                      progress: value,
                      color: color,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2);
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;
  final Color color;

  _GaugePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    // Background arc
    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    final bgRect = Rect.fromCircle(center: center, radius: radius - 16);
    canvas.drawArc(bgRect, -pi, pi, false, bgPaint);

    // Foreground arc
    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..shader = LinearGradient(
        colors: [color.withOpacity(0.6), color],
      ).createShader(bgRect);

    canvas.drawArc(bgRect, -pi, pi * progress.clamp(0.0, 1.0), false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
