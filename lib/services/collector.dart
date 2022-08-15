import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/classes/launch_class.dart';

import '../classes/page_class.dart';

String apiUrl = 'api.spacexdata.com';

Future<List<LaunchClass>?> getUpcomingLaunches() async {
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

Future<PageClass?> getPastLaunches(PageClass? page) async {
  // Get all past rocket launches.
  var url = Uri.https(apiUrl, 'v5/launches/query');
  try {
    var response = await http.post(url, body: jsonEncode({
      "query":{
          "upcoming":false
      },
      "options":{
          "page":page?.nextPage ?? 0,
          "limit": 20,
          "sort": {
            "date_utc": "desc"
          },
        }
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {

      dynamic jsonLaunchData = json.decode(response.body);
      PageClass page = PageClass.fromJson(jsonLaunchData);
      return page;
    } else {
      return null;
    }
  } catch(error) {
    return null;
  }
}