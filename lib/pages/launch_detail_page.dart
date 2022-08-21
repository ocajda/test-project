import 'package:flutter/material.dart';
import 'package:test/classes/launch_class.dart';

class LaunchDetailPage extends StatefulWidget {
  final LaunchClass launch;
  const LaunchDetailPage({
    Key? key, 
    required this.launch
  }) : super(key: key);

  @override
  State<LaunchDetailPage> createState() => _LaunchDetailPageState();
}

class _LaunchDetailPageState extends State<LaunchDetailPage> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.launch.getName()),
      ),
      body: Container(
        child: Text(widget.launch.name!)
      )
    );
  }
}