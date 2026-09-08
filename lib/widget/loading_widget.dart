import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

//加载页
class LoadingWidget extends StatefulWidget {
  final Color backgroundColor;
  final double width;
  final double height;

  const LoadingWidget({
    super.key,
    this.backgroundColor = Colors.white,
    this.width = 110,
    this.height = 110,
  });

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  final List<Color> _KDefaultRainbowColors = const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        width: widget.width,
        height: widget.height,
        color: widget.backgroundColor,
        child: LoadingIndicator(
          indicatorType: Indicator.pacman,
          colors: _KDefaultRainbowColors,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
