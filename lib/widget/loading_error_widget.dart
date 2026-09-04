import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingErrorWidget extends StatefulWidget {
  final String error;
  final Function() retry;
  const LoadingErrorWidget({
    super.key,
    required this.error,
    required this.retry,
  });

  @override
  State<LoadingErrorWidget> createState() => _LoadingErrorWidgetState();
}

class _LoadingErrorWidgetState extends State<LoadingErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/ic_network_error.png',
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 16),
          Text(
            '加载失败',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
