import 'package:flutter/material.dart';

class ProjectMenuWidget extends StatefulWidget {
  const ProjectMenuWidget({super.key});

  @override
  State<ProjectMenuWidget> createState() => _ProjectMenuWidgetState();
}

class _ProjectMenuWidgetState extends State<ProjectMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Project Menu'));
  }
}
