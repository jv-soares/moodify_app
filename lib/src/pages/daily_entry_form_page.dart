import 'package:flutter/material.dart';

import 'components/form_slider.dart';

class DailyEntryFormPage extends StatelessWidget {
  const DailyEntryFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro diário'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              FormSlider(
                label: 'Como você se sente?',
                values: functionalImpairment,
                onChanged: (value) {},
              ),
              FormSlider(
                label: 'Como está seu humor?',
                values: mood,
                onChanged: (value) {},
              ),
              FormSlider(
                label: 'Quantas horas você dormiu?',
                values: List.generate(11, (index) => DescriptiveValue(index)),
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
