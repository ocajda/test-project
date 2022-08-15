import 'package:flutter/material.dart';
import 'package:test/components/deviders/list_devider.dart';

import '../classes/launch_class.dart';
import '../components/tiles/launch_tile.dart';
import '../placeholders/loading_placeholder.dart';
import '../placeholders/no_data_palceholder.dart';
import '../services/collector.dart';

class UpcomingLaunchPage extends StatelessWidget {
  const UpcomingLaunchPage({Key? key}) : super(key: key);

  openDetail(LaunchClass launch) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upcoming launches"),
      ),
      body: FutureBuilder<List<LaunchClass>?>(
        future: getUpcomingLaunches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
              if (!snapshot.hasData) {
                return const PlaceholderNoData();
              }
              List<LaunchClass>? launches = snapshot.data;
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: launches!.length,
                separatorBuilder: (context, index) {
                  return const ListDivider();
                },
                itemBuilder: (context, index) {
                  LaunchClass launch = launches[index];
                  return LaunchTile(
                    launch: launch, 
                    onTap: () => openDetail(launch)
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