import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test/classes/launch_class.dart';




class LaunchTile extends StatelessWidget {

  final LaunchClass launch;
  final VoidCallback onTap;


  const LaunchTile({
    Key? key,
    required this.launch,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        launch.getName(),
      ),
      subtitle: Text(
        launch.getDate(),
      ),
      leading: CachedNetworkImage(
        imageUrl: launch.getSmallImage(),
        width: 60,
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
      trailing: Icon(
        launch.getLaunchIcon(),
        color: launch.getLaunchColor(),
      ),
    );
  }
}
