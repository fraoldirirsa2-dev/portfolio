import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/reveal.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  static const _stats = [
    ('30+', 'Projects shipped'),
    ('5+', 'Years experience'),
    ('12', 'Happy clients'),
    ('100%', 'Delivery rate'),
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final cols = w > 900 ? 4 : (w > 500 ? 2 : 1);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: LayoutBuilder(
        builder: (_, constraints) {
          final cardW = (constraints.maxWidth - (cols - 1) * 16) / cols;
          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: _stats
                .asMap()
                .entries
                .map(
                  (e) => Reveal(
                    delay: Duration(milliseconds: e.key * 100),
                    child: SizedBox(
                      width: cardW,
                      child: _card(e.value.$1, e.value.$2),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }

  Widget _card(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (r) => Gradients.primary.createShader(r),
            child: Text(
              value,
              style: displayFont(
                size: 38,
                color: Colors.white,
                letterSpacing: -1.5,
                text: value,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: bodyFont(size: 13, color: AppColors.muted, text: label),
          ),
        ],
      ),
    );
  }
}
