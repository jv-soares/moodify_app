import 'package:flutter/material.dart';

class MoodifyDraggableBottomSheet extends StatelessWidget {
  final double initialChildSize;
  final double minChildSize;
  final Widget content;

  const MoodifyDraggableBottomSheet({
    super.key,
    required this.initialChildSize,
    required this.minChildSize,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildHandle(context),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: content,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        width: 32,
        height: 4,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
