import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void _finishOnboarding() {
    SharedPreferences.getInstance().then(
      (instance) => instance.setBool('didOnboard', true),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
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
            AnimatedBuilder(
              animation: _pageController,
              builder: (context, _) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _sections.length,
                  (index) => _OnboardingIndicator(
                    index: index,
                    pageController: _pageController,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              child: AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, _) {
                    final currentPage = _pageController.page ?? 0;
                    return MoodifyFilledButton(
                      label: currentPage > 1.4 ? 'Começar' : 'Próximo',
                      horizontallyExpanded: true,
                      onPressed: () {
                        if (currentPage > 1) {
                          _finishOnboarding();
                        } else {
                          _pageController.nextPage(
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 250),
                          );
                        }
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class _OnboardingIndicator extends StatefulWidget {
  final int index;
  final PageController pageController;

  const _OnboardingIndicator({
    required this.index,
    required this.pageController,
  });

  @override
  State<_OnboardingIndicator> createState() => _OnboardingIndicatorState();
}

class _OnboardingIndicatorState extends State<_OnboardingIndicator> {
  late final ColorTween _tween;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final colorScheme = Theme.of(context).colorScheme;
    _tween = ColorTween(
      begin: colorScheme.outlineVariant,
      end: colorScheme.primary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 16,
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: _tween.transform(_calculateIndicatorAnimationValue()),
      ),
    );
  }

  double _calculateIndicatorAnimationValue() {
    final value = widget.pageController.page ?? 0;
    if (widget.index == 0 && value < 1) {
      return 1 - value;
    } else if (value <= widget.index && value > widget.index - 1) {
      return value - (widget.index - 1);
    } else if (value > widget.index && value < widget.index + 1) {
      return (widget.index + 1) - value;
    }
    return 0;
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
