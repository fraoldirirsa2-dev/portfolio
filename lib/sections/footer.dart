import 'package:flutter/material.dart';

import '../theme.dart';
import '../l10n.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border, width: 0.6)),
      ),
      child: Center(
        child: Text(
          t.footer,
          style: bodyFont(size: 13, color: AppColors.muted, text: t.footer),
        ),
      ),
    );
  }
}
