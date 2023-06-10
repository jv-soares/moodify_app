import 'package:flutter/material.dart';

class MoodifyTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String?>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool isMultiline;

  const MoodifyTextFormField({
    Key? key,
    required this.label,
    this.controller,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.textInputAction,
    this.keyboardType,
    this.isMultiline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        TextFormField(
          autocorrect: false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          onChanged: onChanged,
          onSaved: onSaved,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          style: Theme.of(context).textTheme.bodyMedium,
          validator: validator,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          maxLines: isMultiline ? 3 : null,
        ),
      ],
    );
  }
}
