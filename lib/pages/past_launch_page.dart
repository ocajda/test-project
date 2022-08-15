import 'package:flutter/material.dart';
import 'package:test/classes/launch_class.dart';
import 'package:test/placeholders/no_data_palceholder.dart';
import 'package:test/services/collector.dart';

import '../placeholders/loading_placeholder.dart';

class PastLaunchPage extends StatefulWidget {
  const PastLaunchPage({Key? key}) : super(key: key);

  @override
  State<PastLaunchPage> createState() => _PastLaunchPageState();
}

class _PastLaunchPageState extends State<PastLaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Past launches"),
      ),
      body: FutureBuilder<List<LaunchClass>?>(
        future: getPastLaunchs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
              if (!snapshot.hasData) {
                return PlaceholderNoData();
              }
              List<LaunchClass>? launches = snapshot.data;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: launches!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      launches[index].name!,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }, 
              );
            } else {
              return const PlaceholderLoadingData();
            }
        },
      ),
    );
  }
}