import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/project.dart';
import '../services/project_service.dart';
import '../theme.dart';
import '../l10n.dart';
import '../widgets/reveal.dart';
import '../widgets/section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final service = ProjectService();
    final w = MediaQuery.of(context).size.width;
    final cols = w > 1000 ? 3 : (w > 680 ? 2 : 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          child: SectionHeader(
            tag: t.portfolioTag,
            title: t.projectsTitle,
            subtitle: t.projectsSubtitle,
          ),
        ),
        const SizedBox(height: 40),
        StreamBuilder<List<Project>>(
          stream: service.streamProjects(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(60),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              );
            }
            if (!snap.hasData || snap.data!.isEmpty) {
              return _emptyState(t.noProjects);
            }
            final projects = snap.data!;
            return GridView.count(
              crossAxisCount: cols,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.78,
              children: projects
                  .asMap()
                  .entries
                  .map(
                    (e) => Reveal(
                      delay: Duration(milliseconds: e.key * 80),
                      child: _ProjectCard(e.value),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _emptyState(String msg) {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          const Icon(Icons.folder_open, size: 40, color: AppColors.muted),
          const SizedBox(height: 12),
          Text(
            msg,
            style: bodyFont(text: msg, color: AppColors.muted, size: 14),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  const _ProjectCard(this.project);

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hover ? -8 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.card.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _hover
                ? AppColors.primary.withValues(alpha: 0.6)
                : AppColors.border,
          ),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 44,
                    offset: const Offset(0, 22),
                  ),
                ]
              : [],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 10,
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 400),
                    scale: _hover ? 1.06 : 1.0,
                    child: Image.network(
                      p.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: AppColors.bgSoft,
                        child: const Center(
                          child: Icon(
                            Icons.image_outlined,
                            color: AppColors.muted,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.card.withValues(alpha: 0.9),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.title,
                    style: displayFont(
                      size: 20,
                      weight: FontWeight.w700,
                      letterSpacing: -0.5,
                      text: p.title,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    p.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: bodyFont(
                      size: 13.5,
                      height: 1.5,
                      text: p.description,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: p.tags
                        .map(
                          (tg) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              tg,
                              style: bodyFont(
                                size: 11,
                                weight: FontWeight.w500,
                                color: AppColors.primarySoft,
                                text: tg,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    children: p.links.entries
                        .map(
                          (e) => GestureDetector(
                            onTap: () => launchUrl(Uri.parse(e.value)),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    e.key,
                                    style:
                                        bodyFont(
                                          size: 13,
                                          weight: FontWeight.w500,
                                          color: AppColors.text,
                                          text: e.key,
                                        ).copyWith(
                                          decoration: TextDecoration.underline,
                                          decorationColor: AppColors.primary,
                                        ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.north_east,
                                    size: 13,
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
