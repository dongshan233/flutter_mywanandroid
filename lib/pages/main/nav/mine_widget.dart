import 'package:flutter/material.dart';

class MineWddget extends StatefulWidget {
  const MineWddget({super.key});

  @override
  State<MineWddget> createState() => _MineWddgetState();
}

class _MineWddgetState extends State<MineWddget> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Mine widget'));
  }
}
