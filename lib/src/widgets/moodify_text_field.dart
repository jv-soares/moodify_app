import 'package:flutter/material.dart';

class MoodifyTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool isMultiline;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const MoodifyTextField({
    super.key,
    required this.onChanged,
    this.isMultiline = false,
    this.textInputAction,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      maxLines: isMultiline ? 3 : null,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: onChanged,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
    );
  }
}
