import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';
import '../l10n.dart';
import '../widgets/hover_button.dart';
import '../widgets/marquee.dart';
import '../widgets/reveal.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewWork;
  const HeroSection({super.key, required this.onViewWork});

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 760;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.card.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _pulseDot(),
                  const SizedBox(width: 10),
                  Text(
                    t.available,
                    style: bodyFont(
                      size: 13,
                      weight: FontWeight.w500,
                      color: AppColors.text,
                      text: t.available,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          Reveal(
            delay: const Duration(milliseconds: 100),
            child: Text(
              t.heroLine1,
              style: displayFont(
                size: isMobile ? 46 : 96,
                letterSpacing: -3.5,
                height: 0.95,
                text: t.heroLine1,
              ),
            ),
          ),
          Reveal(
            delay: const Duration(milliseconds: 200),
            child: ShaderMask(
              shaderCallback: (r) => Gradients.hero.createShader(r),
              child: Text(
                t.heroLine2,
                style: displayFont(
                  size: isMobile ? 46 : 96,
                  color: Colors.white,
                  letterSpacing: -3.5,
                  height: 0.95,
                  text: t.heroLine2,
                ),
              ),
            ),
          ),
          Reveal(
            delay: const Duration(milliseconds: 300),
            child: Text(
              t.heroLine3,
              style: displayFont(
                size: isMobile ? 46 : 96,
                weight: FontWeight.w300,
                letterSpacing: -3.5,
                height: 0.95,
                color: AppColors.muted,
                text: t.heroLine3,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Reveal(
            delay: const Duration(milliseconds: 400),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Text(
                t.heroTagline,
                style: bodyFont(
                  size: isMobile ? 15 : 17,
                  height: 1.65,
                  text: t.heroTagline,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Reveal(
            delay: const Duration(milliseconds: 500),
            child: Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                HoverButton(
                  onTap: onViewWork,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(t.viewWork),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                GhostButton(
                  label: t.downloadCv,
                  onTap: () => launchUrl(Uri.parse('/resume.pdf')),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          const Marquee(),
        ],
      ),
    );
  }

  Widget _pulseDot() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.5, end: 1),
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      builder: (_, v, _) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: AppColors.accent,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: v * 0.7),
              blurRadius: 12 * v,
              spreadRadius: 2 * v,
            ),
          ],
        ),
      ),
    );
  }
}
