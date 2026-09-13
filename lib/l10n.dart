import 'package:flutter/material.dart';

final localeNotifier = ValueNotifier<Locale>(const Locale('en'));

class L10n {
  final Locale locale;
  L10n(this.locale);

  static L10n of(BuildContext context) => L10n(Localizations.localeOf(context));

  String _t(String key) {
    final lang = locale.languageCode;
    return _strings[lang]?[key] ?? _strings['en']?[key] ?? key;
  }

  // Convenience getters
  String get navProjects => _t('navProjects');
  String get navServices => _t('navServices');
  String get navAbout => _t('navAbout');
  String get navContact => _t('navContact');
  String get hireMe => _t('hireMe');

  String get available => _t('available');
  String get heroLine1 => _t('heroLine1');
  String get heroLine2 => _t('heroLine2');
  String get heroLine3 => _t('heroLine3');
  String get heroTagline => _t('heroTagline');
  String get viewWork => _t('viewWork');
  String get downloadCv => _t('downloadCv');

  String get portfolioTag => _t('portfolioTag');
  String get projectsTitle => _t('projectsTitle');
  String get projectsSubtitle => _t('projectsSubtitle');
  String get noProjects => _t('noProjects');

  String get servicesTag => _t('servicesTag');
  String get servicesTitle => _t('servicesTitle');
  String get servicesSubtitle => _t('servicesSubtitle');

  String get aboutTag => _t('aboutTag');
  String get aboutTitle => _t('aboutTitle');
  String get aboutBody1 => _t('aboutBody1');
  String get aboutBody2 => _t('aboutBody2');
  String get currently => _t('currently');
  String get statAvailable => _t('statAvailable');
  String get statBased => _t('statBased');
  String get statOpen => _t('statOpen');

  String get testimonialsTag => _t('testimonialsTag');
  String get testimonialsTitle => _t('testimonialsTitle');

  String get contactTag => _t('contactTag');
  String get contactTitle => _t('contactTitle');
  String get contactSubtitle => _t('contactSubtitle');
  String get yourName => _t('yourName');
  String get yourEmail => _t('yourEmail');
  String get projectDetails => _t('projectDetails');
  String get sendMessage => _t('sendMessage');
  String get sentOk => _t('sentOk');
  String get sentFail => _t('sentFail');

  String get footer => _t('footer');

  static const Map<String, Map<String, String>> _strings = {
    'en': {
      'navProjects': 'Projects',
      'navServices': 'Services',
      'navAbout': 'About',
      'navContact': 'Contact',
      'hireMe': 'Hire me',

      'available': 'Available for freelance',
      'heroLine1': 'Building',
      'heroLine2': 'digital products',
      'heroLine3': ' with Flutter.',
      'heroTagline': "I'm Your Fraol Dirirsa — a Flutter developer helping startups ship fast, beautiful mobile and web apps.",
      'viewWork': 'View my work',
      'downloadCv': 'Download CV',

      'portfolioTag': 'Portfolio',
      'projectsTitle': 'Selected work',
      'projectsSubtitle': 'Real projects I have shipped.',
      'noProjects': 'No projects yet.',

      'servicesTag': 'Services',
      'servicesTitle': 'What I do',
      'servicesSubtitle': 'End-to-end Flutter delivery.',

      'aboutTag': 'About',
      'aboutTitle': 'Hey, I build things.',
      'aboutBody1': "I'm a Flutter developer with hands-on experience shipping mobile and web apps. I care about clean architecture, smooth UX, and delivering on time — no fluff.",
      'aboutBody2': "I've worked with startups, agencies, and direct clients across fintech, health, e-commerce, and SaaS.",
      'currently': 'CURRENTLY',
      'statAvailable': 'Available for freelance',
      'statBased': 'Based in Your City',
      'statOpen': 'Open to long-term contracts',

      'testimonialsTag': 'Testimonials',
      'testimonialsTitle': 'What clients say',

      'contactTag': 'Contact',
      'contactTitle': "Let's build something.",
      'contactSubtitle': "I'll reply within 24 hours.",
      'yourName': 'Your name',
      'yourEmail': 'Email',
      'projectDetails': 'Tell me about your project',
      'sendMessage': 'Send message',
      'sentOk': 'Message sent ✓',
      'sentFail': 'Failed. Try again.',

      'footer': '© 2026 Fraol Dirirsa. Built with Flutter.',
    },
    'am': {
      'navProjects': 'ሥራዎች',
      'navServices': 'አገልግሎቶች',
      'navAbout': 'ስለ እኔ',
      'navContact': 'አግኙኝ',
      'hireMe': 'ይቅጠሩኝ',

      'available': 'ለፍሪላንስ ዝግጁ ነኝ',
      'heroLine1': 'እየገነባሁ ነው',
      'heroLine2': 'ዲጂታል ምርቶችን',
      'heroLine3': ' በ Flutter።',
      'heroTagline': 'እኔ [ስምዎ] ነኝ — ለስታርትአፖች ፈጣን እና ውብ የሞባይል እና የድረ-ገጽ መተግበሪያዎችን የማዘጋጅ Flutter ገንቢ ነኝ።',
      'viewWork': 'ሥራዬን ይመልከቱ',
      'downloadCv': 'CV ያውርዱ',

      'portfolioTag': 'ፖርትፎሊዮ',
      'projectsTitle': 'የተመረጡ ሥራዎች',
      'projectsSubtitle': 'ያዘጋጀኋቸው እውነተኛ ፕሮጀክቶች።',
      'noProjects': 'እስካሁን ፕሮጀክት የለም።',

      'servicesTag': 'አገልግሎቶች',
      'servicesTitle': 'የማደርጋቸው ነገሮች',
      'servicesSubtitle': 'ከጅምር እስከ መጨረሻ የ Flutter አገልግሎት።',

      'aboutTag': 'ስለ እኔ',
      'aboutTitle': 'ሰላም፣ እኔ ነገሮችን እገነባለሁ።',
      'aboutBody1': 'እኔ የሞባይል እና የድረ-ገጽ መተግበሪያዎችን የማዘጋጅ Flutter ገንቢ ነኝ። ለንጹህ አርክቴክቸር፣ ለሚስብ UX፣ እና በሰዓቱ ለማድረስ ትኩረት እሰጣለሁ።',
      'aboutBody2': 'ከስታርትአፖች፣ ከኤጀንሲዎች፣ እና ከቀጥታ ደንበኞች ጋር በፊንቴክ፣ በጤና፣ በኢ-ኮሜርስ፣ እና በ SaaS ሠርቻለሁ።',
      'currently': 'በአሁኑ ጊዜ',
      'statAvailable': 'ለፍሪላንስ ዝግጁ ነኝ',
      'statBased': 'በ [ከተማዎ] የምገኝ',
      'statOpen': 'ለረዥም ጊዜ ውል ክፍት ነኝ',

      'testimonialsTag': 'ምስክሮች',
      'testimonialsTitle': 'ደንበኞች ምን ይላሉ',

      'contactTag': 'አግኙኝ',
      'contactTitle': 'አንድ ነገር እንገንባ።',
      'contactSubtitle': 'በ24 ሰዓት ውስጥ እመልስልዎታለሁ።',
      'yourName': 'ስምዎ',
      'yourEmail': 'ኢሜይል',
      'projectDetails': 'ስለ ፕሮጀክትዎ ይንገሩኝ',
      'sendMessage': 'መልእክት ላክ',
      'sentOk': 'መልእክት ተልኳል ✓',
      'sentFail': 'አልተሳካም። እንደገና ይሞክሩ።',

      'footer': '© 2026 ፍራኦል ዲሪርሳ ። በ Flutter የተገነባ።',
    },
  };
}
