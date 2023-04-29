import 'package:flutter/material.dart';

class EpisodeSeverityFormPage extends StatefulWidget {
  const EpisodeSeverityFormPage({super.key});

  @override
  State<EpisodeSeverityFormPage> createState() =>
      _EpisodeSeverityFormPageState();
}

class _EpisodeSeverityFormPageState extends State<EpisodeSeverityFormPage> {
  EpisodeSeverity2? _selectedValue = EpisodeSeverity2.balanced;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoje'),
        centerTitle: true,
        leading: IconButton(
          onPressed: Navigator.of(context, rootNavigator: true).pop,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('diary-form/optional');
        },
        child: const Icon(Icons.arrow_forward),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'COMO VOCÊ SE SENTE?',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 16),
              ..._options
                  .map(
                    (e) => RadioListTile<EpisodeSeverity2>(
                      value: e.value,
                      groupValue: _selectedValue,
                      isThreeLine: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        e.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      subtitle: Text(
                        e.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                      ),
                      onChanged: (value) {
                        setState(() => _selectedValue = value);
                      },
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EpisodeSeverityOption {
  final String name;
  final String description;
  final EpisodeSeverity2 value;

  _EpisodeSeverityOption(this.name, this.description, this.value);
}

final _options = [
  _EpisodeSeverityOption(
    'Mania severa',
    'Totalmente incapacitado ou hospitalizado',
    EpisodeSeverity2.maniaSevere,
  ),
  _EpisodeSeverityOption(
    'Mania moderada-alta',
    'Com muita dificuldade em realizar certas atividades',
    EpisodeSeverity2.maniaModerateHigh,
  ),
  _EpisodeSeverityOption(
    'Mania moderada-baixa',
    'Com um pouco de dificuldade em realizar certas atividades',
    EpisodeSeverity2.maniaModerateLow,
  ),
  _EpisodeSeverityOption(
    'Mania leve',
    'Mais energizado e mais produtivo, consigo realizar qualquer atividade normalmente',
    EpisodeSeverity2.maniaMild,
  ),
  _EpisodeSeverityOption(
    'Equilibrado',
    'Consigo realizar qualquer atividade normalmente',
    EpisodeSeverity2.balanced,
  ),
  _EpisodeSeverityOption(
    'Depressão leve',
    'Consigo realizar qualquer atividade normalmente',
    EpisodeSeverity2.depressionMild,
  ),
  _EpisodeSeverityOption(
    'Depressão moderada-baixa',
    'Funcionando com um pouco de esforço',
    EpisodeSeverity2.depressionModerateLow,
  ),
  _EpisodeSeverityOption(
    'Depressão moderada-alta',
    'Funcionando com muito esforço',
    EpisodeSeverity2.depressionModerateHigh,
  ),
  _EpisodeSeverityOption(
    'Depressão severa',
    'Totalmente incapacitado ou hospitalizado',
    EpisodeSeverity2.depressionSevere,
  ),
];

enum EpisodeSeverity2 {
  maniaSevere,
  maniaModerateHigh,
  maniaModerateLow,
  maniaMild,
  balanced,
  depressionMild,
  depressionModerateLow,
  depressionModerateHigh,
  depressionSevere,
}
