import 'package:flutter/material.dart';

import '../theme.dart';

class CustomCursor extends StatefulWidget {
  final Widget child;
  const CustomCursor({super.key, required this.child});

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> {
  Offset _pos = Offset.zero;
  Offset _dot = Offset.zero;
  final bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onHover: (e) {
        setState(() {
          _pos = e.position;
          _dot = _lerp(_dot, _pos, 0.2);
        });
      },
      child: Stack(
        children: [
          widget.child,
          // Outer glow ring
          Positioned(
            left: _dot.dx - 20,
            top: _dot.dy - 20,
            child: IgnorePointer(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: _hovering ? 56 : 40,
                height: _hovering ? 56 : 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          // Inner dot
          Positioned(
            left: _pos.dx - 3,
            top: _pos.dy - 3,
            child: IgnorePointer(
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Offset _lerp(Offset a, Offset b, double t) =>
      Offset(a.dx + (b.dx - a.dx) * t, a.dy + (b.dy - a.dy) * t);
}
