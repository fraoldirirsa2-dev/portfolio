import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

class HoverButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool fullWidth;
  const HoverButton({
    super.key,
    required this.child,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: widget.fullWidth ? double.infinity : null,
          alignment: widget.fullWidth ? Alignment.center : null,
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          decoration: BoxDecoration(
            gradient: Gradients.primary,
            borderRadius: BorderRadius.circular(999),
            boxShadow: _hover
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.55),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: DefaultTextStyle(
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14.5,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class GhostButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const GhostButton({super.key, required this.label, required this.onTap});

  @override
  State<GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<GhostButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          decoration: BoxDecoration(
            color: _hover ? AppColors.card : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: _hover ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              color: AppColors.text,
              fontWeight: FontWeight.w600,
              fontSize: 14.5,
            ),
          ),
        ),
      ),
    );
  }
}
