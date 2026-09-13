import 'package:flutter/material.dart';

import '../theme.dart';
import '../l10n.dart';
import '../widgets/glass_card.dart';
import '../widgets/reveal.dart';
import '../widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  static const _skills = [
    'Flutter',
    'Dart',
    'Firebase',
    'Riverpod',
    'Bloc',
    'REST',
    'GraphQL',
    'Git',
    'CI/CD',
    'Figma',
  ];

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 860;

    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          child: SectionHeader(tag: t.aboutTag, title: t.aboutTitle),
        ),
        const SizedBox(height: 20),
        Reveal(
          delay: const Duration(milliseconds: 100),
          child: Text(
            t.aboutBody1,
            style: bodyFont(size: 15, height: 1.7, text: t.aboutBody1),
          ),
        ),
        const SizedBox(height: 16),
        Reveal(
          delay: const Duration(milliseconds: 200),
          child: Text(
            t.aboutBody2,
            style: bodyFont(size: 15, height: 1.7, text: t.aboutBody2),
          ),
        ),
        const SizedBox(height: 28),
        Reveal(
          delay: const Duration(milliseconds: 300),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _skills
                .map(
                  (s) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.card.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      s,
                      style: bodyFont(
                        size: 13,
                        weight: FontWeight.w500,
                        color: AppColors.text,
                        text: s,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );

    final right = Reveal(
      delay: const Duration(milliseconds: 200),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.currently,
              style: bodyFont(
                size: 12,
                weight: FontWeight.w600,
                color: AppColors.muted,
                text: t.currently,
              ).copyWith(letterSpacing: 2.5),
            ),
            const SizedBox(height: 18),
            _row(Icons.circle, t.statAvailable, AppColors.accent),
            const SizedBox(height: 14),
            _row(Icons.location_on_outlined, t.statBased, AppColors.primary),
            const SizedBox(height: 14),
            _row(Icons.work_outline, t.statOpen, AppColors.accent2),
          ],
        ),
      ),
    );

    return isMobile
        ? Column(children: [left, const SizedBox(height: 24), right])
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: left),
              const SizedBox(width: 40),
              Expanded(flex: 2, child: right),
            ],
          );
  }

  Widget _row(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: bodyFont(size: 14, color: AppColors.text, text: text),
          ),
        ),
      ],
    );
  }
}
