import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/contact_service.dart';
import '../theme.dart';
import '../l10n.dart';
import '../widgets/glass_card.dart';
import '../widgets/hover_button.dart';
import '../widgets/reveal.dart';
import '../widgets/section_header.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();
  final _service = ContactService();
  bool _sending = false;

  Future<void> _send() async {
    final t = L10n.of(context);
    setState(() => _sending = true);
    final ok = await _service.sendEmail(
      name: _name.text.trim(),
      email: _email.text.trim(),
      message: _message.text.trim(),
    );
    if (!mounted) return;
    setState(() => _sending = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? t.sentOk : t.sentFail),
        backgroundColor: ok ? AppColors.accent : Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
    if (ok) {
      _name.clear();
      _email.clear();
      _message.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          child: SectionHeader(
            tag: t.contactTag,
            title: t.contactTitle,
            subtitle: t.contactSubtitle,
          ),
        ),
        const SizedBox(height: 32),
        Reveal(
          delay: const Duration(milliseconds: 150),
          child: GlassCard(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                _field(_name, t.yourName),
                const SizedBox(height: 14),
                _field(_email, t.yourEmail),
                const SizedBox(height: 14),
                _field(_message, t.projectDetails, maxLines: 5),
                const SizedBox(height: 22),
                HoverButton(
                  onTap: _sending ? () {} : _send,
                  fullWidth: true,
                  child: _sending
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(t.sendMessage),
                ),
                const SizedBox(height: 22),
                Wrap(
                  spacing: 22,
                  runSpacing: 12,
                  children: [
                    _link(
                      Icons.mail_outline,
                      'fraoldirirsa2@gmail.com',
                      'mailto:fraoldirirsa2@gmail.com',
                    ),
                    _link(
                      Icons.phone_outlined,
                      '0930203120',
                      'tel:+251930203120',
                    ),
                    _link(
                      Icons.code,
                      'GitHub',
                      'https://github.com/fraoldirirsa2-dev',
                    ),
                    _link(
                      Icons.work_outline,
                      'LinkedIn',
                      'https://www.linkedin.com/in/filyor-designer',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _link(IconData icon, String label, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(url)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(
              label,
              style: bodyFont(
                size: 13.5,
                weight: FontWeight.w500,
                color: AppColors.text,
                text: label,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String hint, {int maxLines = 1}) {
    return TextField(
      controller: c,
      maxLines: maxLines,
      style: bodyFont(size: 14.5, color: AppColors.text, text: hint),
      decoration: InputDecoration(hintText: hint),
    );
  }
}
