import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test/classes/launch_class.dart';
import 'package:test/classes/rocket_class.dart';
import 'package:test/pages/rocket_detail_page.dart';
import 'package:test/services/collector.dart';

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
  RocketClass? rocket;

  openRocket() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RocketDetailPage(
          rocket: rocket!
        ),
      ),
    );
  }

  @override
  void initState() {
    rocket = rockets?.firstWhereOrNull((element) => 
      element.id == widget.launch.rocketId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.launch.getName()),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CachedNetworkImage(
            imageUrl: widget.launch.getLargeImage(),
            width: 120,
            height: 120,
            progressIndicatorBuilder: (context, url, downloadProgress) => 
              Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress
                  )
                ),
              ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.launch.isUpcomming() ? "Launch date" : "Launched"
              ),
              Text(widget.launch.getDate()),
            ],
          ),
          if (!widget.launch.isUpcomming())
            const SizedBox(height: 16,),
          if (!widget.launch.isUpcomming())
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Result of launch"),
                Text(
                  widget.launch.getLaunchResult(),
                  style: TextStyle(
                    color: widget.launch.getLaunchColor(),
                  ),
                ),
              ],
            ),
          if (rocket != null)
            const SizedBox(height: 16,),
          if (rocket != null)
            InkWell(
              onTap: openRocket,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Rocket",
                      style: TextStyle(
                        decoration: TextDecoration.underline
                      ),
                    ),
                    Text(
                      rocket!.name!,
                      style: const TextStyle(
                        decoration: TextDecoration.underline
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Flight number"
              ),
              Text(widget.launch.getFlightNumber()),
            ],
          ),
          const SizedBox(height: 16,),
          Text(widget.launch.getDescription()),
        ],

      )
    );
  }
}