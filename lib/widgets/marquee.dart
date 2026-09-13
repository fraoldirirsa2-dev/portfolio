import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

class Marquee extends StatefulWidget {
  const Marquee({super.key});

  @override
  State<Marquee> createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  final _items = const [
    'Flutter',
    'Dart',
    'Firebase',
    'Riverpod',
    'Bloc',
    'REST API',
    'GraphQL',
    'Stripe',
    'CI/CD',
    'Figma',
  ];

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 25))
      ..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _c,
          builder: (_, _) {
            return ShaderMask(
              shaderCallback: (r) => const LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white,
                  Colors.white,
                  Colors.transparent,
                ],
                stops: [0, 0.08, 0.92, 1],
              ).createShader(r),
              blendMode: BlendMode.dstIn,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, i) {
                  return Transform.translate(
                    offset: Offset(-_c.value * 1400, 0),
                    child: Row(
                      children: _items
                          .map(
                            (s) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 26,
                                vertical: 14,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    s.toUpperCase(),
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 2.5,
                                      color: AppColors.muted,
                                    ),
                                  ),
                                  const SizedBox(width: 26),
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.6,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
