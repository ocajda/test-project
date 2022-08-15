import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/classes/launch_class.dart';

String apiUrl = 'api.spacexdata.com';

Future<List<LaunchClass>?> getUpcomingLaunchs() async {
  // Get all upcominig rocket launches.
  var url = Uri.https(apiUrl, 'v5/launches/upcoming');
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {

      List<dynamic> jsonLaunchData = json.decode(response.body);
      List<LaunchClass> list = jsonLaunchData
          .map((launch) => LaunchClass.fromJson(launch))
          .toList();
      return list;
    } else {
      return null;
    }
  } catch(error) {
    return null;
  }
}

Future<List<LaunchClass>?> getPastLaunchs() async {
  // Get all past rocket launches.
  var url = Uri.https(apiUrl, 'v5/launches/past');
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {

      List<dynamic> jsonLaunchData = json.decode(response.body);
      List<LaunchClass> list = jsonLaunchData
          .map((launch) => LaunchClass.fromJson(launch))
          .toList();
      return list;
    } else {
      return null;
    }
  } catch(error) {
    return null;
  }
}