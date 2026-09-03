import 'package:flutter/material.dart';

class DoubleBackExitWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final String? message;
  final Function? onDoubleBack;
  final Function? onSingleBack;

  const DoubleBackExitWidget({
    super.key,
    this.duration = const Duration(seconds: 2),
    required this.child,
    this.message,
    this.onDoubleBack,
    this.onSingleBack,
  });

  @override
  State<DoubleBackExitWidget> createState() => _DoubleBackExitWidgetState();
}

class _DoubleBackExitWidgetState extends State<DoubleBackExitWidget> {
  DateTime? _lastPressedAt;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        final now = DateTime.now();
        if (_lastPressedAt != null &&
            now.difference(_lastPressedAt!) < widget.duration) {
          widget.onDoubleBack?.call();
        } else {
          _lastPressedAt = now;
          widget.onSingleBack?.call();
        }
      },
      child: widget.child,
    );
  }
}
