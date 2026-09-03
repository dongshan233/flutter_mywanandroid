import 'package:flutter/material.dart';

class SystemWidget extends StatefulWidget {
  const SystemWidget({super.key});

  @override
  State<SystemWidget> createState() => _SystemWidgetState();
}

class _SystemWidgetState extends State<SystemWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('system widget'));
  }
}
