import 'package:flutter/material.dart';

class NoiseOverlay extends StatelessWidget {
  const NoiseOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: 0.035,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.transparent, Colors.white],
              stops: [0, 0.5, 1],
            ),
          ),
        ),
      ),
    );
  }
}
