import 'package:flutter/material.dart';

import '../theme.dart';

class SectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String? subtitle;
  const SectionHeader({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 24, height: 1, color: AppColors.primary),
            const SizedBox(width: 10),
            Text(
              tag.toUpperCase(),
              style: bodyFont(
                size: 12,
                weight: FontWeight.w600,
                color: AppColors.primary,
                text: tag,
              ).copyWith(letterSpacing: 3),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: displayFont(
            size: 46,
            letterSpacing: -1.8,
            height: 1.05,
            text: title,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(
            subtitle!,
            style: bodyFont(size: 15, color: AppColors.muted, text: subtitle!),
          ),
        ],
      ],
    );
  }
}
