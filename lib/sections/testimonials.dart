import 'package:flutter/material.dart';

import '../theme.dart';
import '../l10n.dart';
import '../widgets/reveal.dart';
import '../widgets/section_header.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  static const _items = [
    (
      'Sarah K.',
      'Founder, Fintech App',
      'Delivered ahead of schedule and the quality was outstanding. Communication was top-notch.',
    ),
    (
      'Marcus D.',
      'CTO, Health Startup',
      'One of the best Flutter developers we have worked with. Clean code, great UI sense.',
    ),
    (
      'Aisha R.',
      'Product Lead',
      'Turned our Figma designs into a beautiful app. Fast, responsive, and professional.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final w = MediaQuery.of(context).size.width;
    final cols = w > 1000 ? 3 : (w > 680 ? 2 : 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          child: SectionHeader(
            tag: t.testimonialsTag,
            title: t.testimonialsTitle,
          ),
        ),
        const SizedBox(height: 40),
        GridView.count(
          crossAxisCount: cols,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: 1.15,
          children: _items
              .asMap()
              .entries
              .map(
                (e) => Reveal(
                  delay: Duration(milliseconds: e.key * 100),
                  child: _card(e.value.$1, e.value.$2, e.value.$3),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _card(String name, String role, String quote) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              5,
              (i) => const Padding(
                padding: EdgeInsets.only(right: 2),
                child: Icon(Icons.star, size: 14, color: AppColors.accent),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Text(
              '"$quote"',
              style: bodyFont(
                size: 14.5,
                color: AppColors.text,
                height: 1.6,
                text: quote,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  gradient: Gradients.primary,
                  borderRadius: BorderRadius.circular(999),
                ),
                alignment: Alignment.center,
                child: Text(
                  name[0],
                  style: displayFont(
                    size: 16,
                    color: Colors.white,
                    letterSpacing: 0,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: bodyFont(
                      size: 13.5,
                      weight: FontWeight.w600,
                      color: AppColors.text,
                      text: name,
                    ),
                  ),
                  Text(
                    role,
                    style: bodyFont(
                      size: 12,
                      color: AppColors.muted,
                      text: role,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
