import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/moodify_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: _sections
                  .map((e) => _OnboardingView(
                        image: SvgPicture.asset(e.assetPath),
                        title: e.title,
                        description: e.description,
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 64),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _sections.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 24,
                height: 8,
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: MoodifyFilledButton(
              label: 'Próximo',
              horizontallyExpanded: true,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class _OnboardingView extends StatelessWidget {
  final Widget image;
  final String title;
  final String description;

  const _OnboardingView({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: screenSize.height / 3.7,
          child: image,
        ),
        const SizedBox(height: 64),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: screenSize.width / 1.4,
          child: Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _OnboardingSection {
  final String assetPath;
  final String title;
  final String description;

  _OnboardingSection(this.assetPath, this.title, this.description);
}

final _sections = [
  _OnboardingSection(
    'assets/illustrations/undraw_feeling_happy.svg',
    'Bem-vindo!',
    'Registre seu humor diariamente, incluindo sintomas, medicação e acontecimentos.',
  ),
  _OnboardingSection(
    'assets/illustrations/undraw_investing.svg',
    'Veja insights',
    'Com a ajuda de gráficos, entenda como o seu sono e rotina podem influenciar suas oscilações de humor.',
  ),
  _OnboardingSection(
    'assets/illustrations/undraw_secure_files.svg',
    'Privacidade garantida',
    'Seus dados serão armazenados no dispositivo e não serão enviados para nenhum outro lugar, pode ficar tranquilo!',
  ),
];
