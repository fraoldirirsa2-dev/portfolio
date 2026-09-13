import 'package:flutter/material.dart';

import '../theme.dart';
import '../l10n.dart';
import '../widgets/hover_button.dart';
import '../widgets/language_switcher.dart';

class Navbar extends StatefulWidget {
  final void Function(String) onNav;
  const Navbar({super.key, required this.onNav});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pos = Scrollable.of(context).position;
      pos.addListener(() {
        if (mounted) setState(() => _scrolled = pos.pixels > 20);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final isMobile = MediaQuery.of(context).size.width < 900;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: _scrolled
            ? AppColors.bg.withValues(alpha: 0.85)
            : AppColors.bg.withValues(alpha: 0.4),
        border: const Border(
          bottom: BorderSide(color: AppColors.border, width: 0.6),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1160),
          child: Row(
            children: [
              ShaderMask(
                shaderCallback: (r) => Gradients.primary.createShader(r),
                child: Text(
                  'Fraol Dirirsa',
                  style: displayFont(
                    size: 20,
                    weight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const Spacer(),
              if (!isMobile) ...[
                _navBtn(t.navProjects, () => widget.onNav('projects')),
                _navBtn(t.navServices, () => widget.onNav('services')),
                _navBtn(t.navAbout, () => widget.onNav('about')),
                _navBtn(t.navContact, () => widget.onNav('contact')),
                const SizedBox(width: 8),
                const LanguageSwitcher(),
                const SizedBox(width: 12),
                HoverButton(
                  onTap: () => widget.onNav('contact'),
                  child: Text(t.hireMe),
                ),
              ] else ...[
                const LanguageSwitcher(),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _showMenu(context),
                  icon: const Icon(Icons.menu, color: AppColors.text),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _navBtn(String label, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.muted,
        padding: const EdgeInsets.symmetric(horizontal: 14),
      ),
      child: Text(
        label,
        style: bodyFont(
          size: 14,
          weight: FontWeight.w500,
          color: AppColors.muted,
          text: label,
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    final t = L10n.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _menuItem(context, t.navProjects, 'projects'),
            _menuItem(context, t.navServices, 'services'),
            _menuItem(context, t.navAbout, 'about'),
            _menuItem(context, t.navContact, 'contact'),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(BuildContext context, String label, String key) {
    return ListTile(
      title: Text(
        label,
        style: bodyFont(
          size: 16,
          weight: FontWeight.w500,
          color: AppColors.text,
          text: label,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        widget.onNav(key);
      },
    );
  }
}
