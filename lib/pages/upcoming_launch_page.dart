import 'package:flutter/material.dart';

import '../classes/launch_class.dart';
import '../placeholders/loading_placeholder.dart';
import '../placeholders/no_data_palceholder.dart';
import '../services/collector.dart';

class UpcomingLaunchPage extends StatelessWidget {
  const UpcomingLaunchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming launches"),
      ),
      body: FutureBuilder<List<LaunchClass>?>(
        future: getUpcomingLaunchs(),
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