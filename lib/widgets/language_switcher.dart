import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';
import '../l10n.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, _) {
        return PopupMenuButton<String>(
          tooltip: 'Language',
          color: AppColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: AppColors.border),
          ),
          onSelected: (code) {
            localeNotifier.value = Locale(code);
          },
          itemBuilder: (_) => [
            _item('en', 'English', locale.languageCode == 'en'),
            _item('am', 'አማርኛ', locale.languageCode == 'am'),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.language, size: 16, color: AppColors.text),
                const SizedBox(width: 6),
                Text(
                  locale.languageCode == 'am' ? 'አማ' : 'EN',
                  style: GoogleFonts.inter(
                    color: AppColors.text,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  PopupMenuItem<String> _item(String code, String label, bool active) {
    return PopupMenuItem(
      value: code,
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: active ? AppColors.primary : AppColors.text,
              fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          if (active) ...[
            const Spacer(),
            const Icon(Icons.check, size: 16, color: AppColors.primary),
          ],
        ],
      ),
    );
  }
}
