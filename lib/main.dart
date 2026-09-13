import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'theme.dart';
import 'l10n.dart';
import 'widgets/cursor.dart';
import 'widgets/aurora.dart';
import 'widgets/noise.dart';
import 'sections/navbar.dart';
import 'sections/hero.dart';
import 'sections/stats.dart';
import 'sections/projects.dart';
import 'sections/services.dart';
import 'sections/about.dart';
import 'sections/testimonials.dart';
import 'sections/contact.dart';
import 'sections/footer.dart';
import 'admin/admin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await loadSavedLocale();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, _) {
        return MaterialApp(
          title: 'Fraol Dirirsa — Flutter Developer',
          debugShowCheckedModeBanner: false,
          theme: buildTheme(),
          locale: locale,
          supportedLocales: const [Locale('en'), Locale('am')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocale, supported) {
            return locale;
          },
          initialRoute: '/',
          routes: {
            '/': (_) => const HomePage(),
            '/admin': (_) => const AdminPage(),
          },
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _keys = {
    'home': GlobalKey(),
    'projects': GlobalKey(),
    'services': GlobalKey(),
    'about': GlobalKey(),
    'contact': GlobalKey(),
  };

  void _scrollTo(String key) {
    final ctx = _keys[key]!.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCursor(
      child: Scaffold(
        body: Stack(
          children: [
            const AuroraBackground(),
            const NoiseOverlay(),
            Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 88),
                    _wrap(
                      key: _keys['home'],
                      child: HeroSection(
                        onViewWork: () => _scrollTo('projects'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _wrap(child: const StatsSection()),
                    _wrap(
                      key: _keys['projects'],
                      child: const ProjectsSection(),
                    ),
                    _wrap(
                      key: _keys['services'],
                      child: const ServicesSection(),
                    ),
                    _wrap(key: _keys['about'], child: const AboutSection()),
                    _wrap(child: const TestimonialsSection()),
                    _wrap(key: _keys['contact'], child: const ContactSection()),
                    const Footer(),
                  ],
                ),
              ),
            ),
            Navbar(onNav: _scrollTo),
          ],
        ),
      ),
    );
  }

  Widget _wrap({Key? key, required Widget child}) {
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1160),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: child,
          ),
        ),
      ),
    );
  }
}
