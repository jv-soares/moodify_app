import 'package:flutter/material.dart';
import 'package:moodify_app/src/model/life_event.dart';
import 'package:provider/provider.dart';

import '../../../widgets/moodify_button.dart';
import 'life_event_form.dart';

class LifeEventSection extends StatefulWidget {
  final ValueChanged<LifeEvent> onChanged;

  const LifeEventSection({super.key, required this.onChanged});

  @override
  State<LifeEventSection> createState() => _LifeEventSectionState();
}

class _LifeEventSectionState extends State<LifeEventSection> {
  final _formNotifier = LifeEventFormNotifier();
  bool _isShowingForm = false;

  @override
  void initState() {
    super.initState();
    _formNotifier.addListener(_notifyOnChanged);
  }

  void _notifyOnChanged() => widget.onChanged(_formNotifier.value);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _formNotifier,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'ACONTECIMENTO',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _isShowingForm
              ? const LifeEventForm()
              : MoodifyFilledButton(
                  label: 'Adicionar medicação',
                  icon: Icons.add,
                  onPressed: () {
                    setState(() => _isShowingForm = true);
                  },
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _formNotifier.removeListener(_notifyOnChanged);
    _formNotifier.dispose();
    super.dispose();
  }
}

class LifeEventFormNotifier extends ValueNotifier<LifeEvent> {
  LifeEventFormNotifier()
      : super(const LifeEvent(description: '', impactRating: 0));

  void onDescriptionChanged(String newValue) {
    value = LifeEvent(description: newValue, impactRating: value.impactRating);
  }

  void onImpactRatingChanged(int newValue) {
    value = LifeEvent(description: value.description, impactRating: newValue);
  }
}
