import 'package:flutter/material.dart';

/// Common loading indicator widget
/// Can be used as overlay or inline
class LoadingIndicator extends StatelessWidget {
  final String? message;
  final bool isOverlay;
  final Color? color;

  const LoadingIndicator({
    super.key,
    this.message,
    this.isOverlay = false,
    this.color,
  });

  const LoadingIndicator.overlay({
    super.key,
    this.message,
    this.color,
  }) : isOverlay = true;

  @override
  Widget build(BuildContext context) {
    final indicator = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: color ?? Theme.of(context).colorScheme.onSurface,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (isOverlay) {
      return Container(
        color: Colors.black54,
        child: Center(child: indicator),
      );
    }

    return Center(child: indicator);
  }
}

/// Loading indicator for list items (inline)
class InlineLoadingIndicator extends StatelessWidget {
  const InlineLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}
