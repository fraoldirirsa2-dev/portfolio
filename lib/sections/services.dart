import 'package:flutter/material.dart';

import '../theme.dart';
import '../l10n.dart';
import '../widgets/glass_card.dart';
import '../widgets/reveal.dart';
import '../widgets/section_header.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  static const _items = [
    (Icons.phone_iphone, 'Mobile apps', 'iOS & Android from idea to store.'),
    (Icons.web_asset, 'Flutter web', 'Dashboards, PWAs, internal tools.'),
    (Icons.hub_outlined, 'API integration', 'REST, GraphQL, Firebase.'),
    (Icons.auto_awesome_outlined, 'UI/UX', 'Pixel-perfect Flutter UI.'),
    (Icons.speed_outlined, 'Performance', 'Optimize, profile, fix bugs.'),
    (Icons.architecture_outlined, 'Consulting', 'Architecture & reviews.'),
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
            tag: t.servicesTag,
            title: t.servicesTitle,
            subtitle: t.servicesSubtitle,
          ),
        ),
        const SizedBox(height: 40),
        GridView.count(
          crossAxisCount: cols,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: 1.5,
          children: _items
              .asMap()
              .entries
              .map(
                (e) => Reveal(
                  delay: Duration(milliseconds: e.key * 80),
                  child: GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            gradient: Gradients.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            e.value.$1,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          e.value.$2,
                          style: displayFont(
                            size: 18,
                            weight: FontWeight.w700,
                            letterSpacing: -0.3,
                            text: e.value.$2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          e.value.$3,
                          style: bodyFont(
                            size: 13,
                            height: 1.5,
                            text: e.value.$3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
