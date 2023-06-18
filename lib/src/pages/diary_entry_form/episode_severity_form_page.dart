import 'package:flutter/material.dart';
import 'package:moodify_app/src/pages/diary_entry_form/view_models/diary_entry_view_model.dart';
import 'package:provider/provider.dart';

import '../../models/episode_severity.dart';

class EpisodeSeverityFormPage extends StatefulWidget {
  const EpisodeSeverityFormPage({super.key});

  @override
  State<EpisodeSeverityFormPage> createState() =>
      _EpisodeSeverityFormPageState();
}

class _EpisodeSeverityFormPageState extends State<EpisodeSeverityFormPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DiaryEntryViewModel>();
    return Scaffold(
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
                    (e) => RadioListTile<EpisodeSeverity>(
                      value: e.value,
                      groupValue: viewModel.episodeSeverity,
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
                        if (value != null) {
                          context
                              .read<DiaryEntryViewModel>()
                              .update(episodeSeverity: value);
                        }
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
  final EpisodeSeverity value;

  _EpisodeSeverityOption(this.name, this.description, this.value);
}

final _options = [
  _EpisodeSeverityOption(
    'Mania severa',
    'Totalmente incapacitado ou hospitalizado',
    EpisodeSeverity.maniaSevere,
  ),
  _EpisodeSeverityOption(
    'Mania moderada-alta',
    'Com muita dificuldade em realizar certas atividades',
    EpisodeSeverity.maniaModerateHigh,
  ),
  _EpisodeSeverityOption(
    'Mania moderada-baixa',
    'Com um pouco de dificuldade em realizar certas atividades',
    EpisodeSeverity.maniaModerateLow,
  ),
  _EpisodeSeverityOption(
    'Mania leve',
    'Mais energizado e mais produtivo, consigo realizar qualquer atividade normalmente',
    EpisodeSeverity.maniaMild,
  ),
  _EpisodeSeverityOption(
    'Equilibrado',
    'Consigo realizar qualquer atividade normalmente',
    EpisodeSeverity.balanced,
  ),
  _EpisodeSeverityOption(
    'Depressão leve',
    'Consigo realizar qualquer atividade normalmente',
    EpisodeSeverity.depressionMild,
  ),
  _EpisodeSeverityOption(
    'Depressão moderada-baixa',
    'Funcionando com um pouco de esforço',
    EpisodeSeverity.depressionModerateLow,
  ),
  _EpisodeSeverityOption(
    'Depressão moderada-alta',
    'Funcionando com muito esforço',
    EpisodeSeverity.depressionModerateHigh,
  ),
  _EpisodeSeverityOption(
    'Depressão severa',
    'Totalmente incapacitado ou hospitalizado',
    EpisodeSeverity.depressionSevere,
  ),
];
