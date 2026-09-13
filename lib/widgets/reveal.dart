import 'package:flutter/material.dart';

class Reveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final double offsetY;
  const Reveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offsetY = 40,
  });

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> {
  bool _shown = false;
  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
    // Re-check on scroll
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _key.currentContext;
      if (ctx != null) {
        Scrollable.of(ctx).position.addListener(_check);
      }
    });
  }

  void _check() {
    final ctx = _key.currentContext;
    if (ctx == null || _shown) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null) return;
    final pos = box.localToGlobal(Offset.zero);
    final screenH = MediaQuery.of(ctx).size.height;
    if (pos.dy < screenH * 0.85) {
      Future.delayed(widget.delay, () {
        if (mounted) setState(() => _shown = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _key,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
        opacity: _shown ? 1 : 0,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          offset: _shown ? Offset.zero : Offset(0, widget.offsetY / 100),
          child: widget.child,
        ),
      ),
    );
  }
}
