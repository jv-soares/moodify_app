import 'package:flutter/material.dart';

class MoodifyPrimaryContainer extends StatefulWidget {
  final Widget child;
  final double? width;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final List<PopupMenuEntry>? popupItems;

  const MoodifyPrimaryContainer({
    required this.child,
    this.width,
    this.borderRadius,
    this.padding,
    this.popupItems,
    super.key,
  });

  @override
  State<MoodifyPrimaryContainer> createState() =>
      _MoodifyPrimaryContainerState();
}

class _MoodifyPrimaryContainerState extends State<MoodifyPrimaryContainer> {
  Offset? _tapPosition;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primaryContainer,
      borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
      child: InkWell(
        onTapDown: (details) => _tapPosition = details.globalPosition,
        onLongPress:
            widget.popupItems != null ? () => _showContextMenu(context) : null,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
        splashFactory: InkRipple.splashFactory,
        splashColor: Theme.of(context).colorScheme.primary,
        overlayColor: MaterialStateProperty.all(
          Theme.of(context).colorScheme.primary.withOpacity(.1),
        ),
        child: Container(
          width: widget.width,
          padding: widget.padding ?? const EdgeInsets.all(16),
          child: widget.child,
        ),
      ),
    );
  }

  Future<void> _showContextMenu(BuildContext context) {
    final containerSize = (context.findRenderObject() as RenderBox).size;
    return showMenu(
      context: context,
      position: RelativeRect.fromSize(
        Rect.fromLTWH(
          _tapPosition!.dx,
          _tapPosition!.dy - containerSize.height,
          0,
          0,
        ),
        containerSize,
      ),
      items: widget.popupItems!,
    );
  }
}
