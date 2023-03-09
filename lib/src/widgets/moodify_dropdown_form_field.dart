import 'package:flutter/material.dart';

class MoodifyDropdownFormField<T extends Enum> extends StatelessWidget {
  final T value;
  final List<T> items;
  final ValueChanged<T> onChanged;

  const MoodifyDropdownFormField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: value,
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
          .toList(),
      onChanged: (value) => onChanged(value as T),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
