import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/classes/launch_class.dart';
import 'package:test/components/tiles/launch_tile.dart';
import 'package:test/placeholders/no_data_palceholder.dart';
import 'package:test/services/collector.dart';

import '../classes/page_class.dart';
import '../components/deviders/list_devider.dart';
import '../placeholders/loading_placeholder.dart';

class PastLaunchPage extends StatefulWidget {
  const PastLaunchPage({Key? key}) : super(key: key);

  @override
  State<PastLaunchPage> createState() => _PastLaunchPageState();
}

class _PastLaunchPageState extends State<PastLaunchPage> {

  PageClass? page;
  bool loadingInProgress = false;
  BehaviorSubject<List<LaunchClass>> obsLaunches = BehaviorSubject<List<LaunchClass>>();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    preloadLaunches();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8 
            && !loadingInProgress && page!.hasNextPage!) {
            loadingInProgress = true;
            PageClass? newPage = await getPastLaunches(page);
            if (newPage != null) {
              List<LaunchClass> loadedLaunch = obsLaunches.value;
              loadedLaunch.addAll(newPage.launches!);
              page = newPage;
              obsLaunches.sink.add(loadedLaunch);
            }
            loadingInProgress = false;
      }
    });
    super.initState();
  }

  preloadLaunches() async {
    obsLaunches.sink.add([]);
    PageClass? newPage = await getPastLaunches(null);
    if (newPage != null) {
      page = newPage;
      obsLaunches.sink.add(newPage.launches!);
    }
  }

  openDetail(LaunchClass launch) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Past launches"),
        actions: [
          IconButton(
            onPressed: preloadLaunches, 
            icon: const Icon(
              Icons.refresh
            )
          )
        ],
      ),
      body: StreamBuilder<List<LaunchClass>?>(
        stream: obsLaunches,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
              if (!snapshot.hasData) {
                return const PlaceholderNoData();
              }
              List<LaunchClass>? launches = snapshot.data;
              return ListView.separated(
                controller: _scrollController,
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