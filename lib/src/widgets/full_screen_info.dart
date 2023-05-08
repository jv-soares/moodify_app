import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FullScreenInfo extends StatelessWidget {
  final String svgAsset;
  final String title;
  final String description;

  const FullScreenInfo({
    super.key,
    required this.svgAsset,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: screenSize.height / 8),
          SvgPicture.asset(svgAsset, height: screenSize.height / 4),
          const SizedBox(height: 64),
          SizedBox(
            width: screenSize.width / 1.4,
            child: Column(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
