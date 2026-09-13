import 'package:flutter/material.dart';

class Service {
  final IconData icon;
  final String title;
  final String desc;
  Service(this.icon, this.title, this.desc);
}

final services = <Service>[
  Service(
    Icons.phone_android,
    'Flutter Mobile Apps',
    'iOS & Android apps from idea to store release.',
  ),
  Service(
    Icons.web,
    'Flutter Web Apps',
    'Dashboards, PWAs, and internal tools.',
  ),
  Service(Icons.api, 'API Integration', 'REST, GraphQL, Firebase, Supabase.'),
  Service(
    Icons.design_services,
    'UI/UX Implementation',
    'Pixel-perfect designs into Flutter.',
  ),
  Service(
    Icons.bug_report,
    'Bug Fixing',
    'Performance, crashes, and maintenance.',
  ),
  Service(
    Icons.support_agent,
    'Consulting',
    'Architecture, state management, and code reviews.',
  ),
];

final skills = <String>[
  'Flutter',
  'Dart',
  'Firebase',
  'REST API',
  'GraphQL',
  'Provider',
  'Riverpod',
  'Bloc',
  'Git',
  'CI/CD',
  'Figma',
  'Stripe',
];
