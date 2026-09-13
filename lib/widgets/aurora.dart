import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme.dart';

class AuroraBackground extends StatefulWidget {
  const AuroraBackground({super.key});

  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 20))
      ..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, _) {
          final t = _c.value * 2 * math.pi;
          return Stack(
            children: [
              Container(color: AppColors.bg),
              _blob(
                AppColors.primary.withValues(alpha: 0.28),
                560,
                Offset(-180 + 120 * math.sin(t), -160 + 90 * math.cos(t)),
              ),
              _blob(
                AppColors.accent.withValues(alpha: 0.22),
                480,
                Offset(
                  MediaQuery.of(context).size.width -
                      320 +
                      80 * math.cos(t + 1),
                  200 + 100 * math.sin(t + 1),
                ),
              ),
              _blob(
                AppColors.accent2.withValues(alpha: 0.18),
                520,
                Offset(
                  200 + 130 * math.sin(t + 2),
                  MediaQuery.of(context).size.height -
                      260 +
                      80 * math.cos(t + 2),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _blob(Color color, double size, Offset pos) {
    return Positioned(
      left: pos.dx,
      top: pos.dy,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
        ),
      ),
    );
  }
}
