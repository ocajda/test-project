import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/classes/launch_class.dart';
import 'package:test/components/tiles/launch_tile.dart';
import 'package:test/pages/launch_detail_page.dart';
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
  bool firstOpen = true;
  BehaviorSubject<List<LaunchClass>> obsLaunches 
    = BehaviorSubject<List<LaunchClass>>();
  TextEditingController searchQueryController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  DateTimeRange? dateRange;

  @override
  void initState() {
    preloadLaunches();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8 
            && !loadingInProgress && page!.hasNextPage!) {
            loadingInProgress = true;
            PageClass? newPage = await getPastLaunches(
              page, 
              searchQueryController.value.text, 
              dateRange?.start, 
              dateRange?.end
            );
            if (newPage != null) {
              List<LaunchClass> loadedLaunch = obsLaunches.value;
              loadedLaunch.addAll(newPage.launches!);
              page = newPage;
              obsLaunches.sink.add(loadedLaunch);
            }
            loadingInProgress = false;
      }
    });
    searchQueryController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 500), () async {
          PageClass? newPage = await getPastLaunches(
            null, 
            searchQueryController.value.text, 
            dateRange?.start, 
            dateRange?.end
          );
          if (newPage != null) {
            page = newPage;
            obsLaunches.sink.add(newPage.launches!);
          }
          setState(() {});
      });
    });
    super.initState();
  }

  preloadLaunches() async {
    if (firstOpen) {
      final prefs = await SharedPreferences.getInstance();
      String? startDateString = prefs.getString('startDate');
      String? endDateString = prefs.getString('endDate');
      if (startDateString != null && endDateString != null) {
        dateRange = DateTimeRange(
          start: DateTime.parse(startDateString), 
          end: DateTime.parse(endDateString), 
        );
      }
      
      firstOpen = false;
    }
    PageClass? newPage = await getPastLaunches(
      null, 
      searchQueryController.value.text, 
      dateRange?.start, 
      dateRange?.end
    );
    if (newPage != null) {
      page = newPage;
      obsLaunches.sink.add(newPage.launches!);
    }
  }

  openDetail(LaunchClass launch) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => LaunchDetailPage(
          launch: launch
        ),
      ),
    );
  }

  openRangeDatepicker() async {
    DateTime now = DateTime.now();
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 30, 1, 1),
      lastDate: now,
      currentDate: now,
      initialDateRange: dateRange,
      saveText: 'Done',
    );
    if (result != null) {
      // Rebuild the UI
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('startDate', result.start.toString());
      await prefs.setString('endDate', result.end.toString());
      setState(() {
        dateRange = result;
      });
      preloadLaunches();
    }
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
          ),
          IconButton(
            onPressed: openRangeDatepicker, 
            icon: const Icon(
              Icons.filter_list
            )
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: TextField(
            controller: searchQueryController,
            
            decoration: InputDecoration(
              hintText: "Search Data...",
              border: InputBorder.none,
              hintStyle: const TextStyle(color: Colors.white70),
              prefixIcon: const Icon(Icons.search, color: Colors.white,),
              suffixIcon: IconButton(
                onPressed: searchQueryController.clear,
                icon: Icon(
                  Icons.clear, 
                  color: searchQueryController.text != "" 
                    ? Colors.white 
                    : Colors.transparent
                  ),
              ),
            ),
            style: const TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
      body: StreamBuilder<List<LaunchClass>?>(
        stream: obsLaunches,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
              if (!snapshot.hasData) {
                return const PlaceholderLoadingData();
              }
              List<LaunchClass>? launches = snapshot.data;
              if (launches!.isEmpty) {
                return const PlaceholderNoData();
              }
              return ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: launches.length,
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