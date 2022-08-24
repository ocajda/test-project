import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/classes/launch_class.dart';
import 'package:test/classes/rocket_class.dart';

import '../classes/page_class.dart';

String apiUrl = 'api.spacexdata.com';

List<RocketClass>? rockets;

Future<List<RocketClass>?> getAllRocketsForFilter() async {
  // Get all rockets for filter and details.
  var url = Uri.https(apiUrl, 'v4/rockets');
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonRocketData = json.decode(response.body);
      List<RocketClass> list = jsonRocketData 
          .map((launch) => RocketClass.fromJson(launch))
          .toList();
      rockets = list;
      return list;
    } else {
      return null;
    }
  } catch(error) {
    return null;
  }
}

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

Future<PageClass?> getPastLaunches(
  PageClass? page, 
  String? searchText, 
  DateTime? startDate, 
  DateTime? endDate,
  RocketClass? rocket
) async {
  // Get all past rocket launches by filter parameters.
  var url = Uri.https(apiUrl, 'v5/launches/query');
  try {
    Map data = {
      "query": {
        "upcoming":false,
        "date_utc": {
          "\$gte": startDate != null ? startDate.toString() : "2000-01-01T00:00:00.000Z",
          "\$lte": endDate != null ? endDate.toString() : DateTime.now().toString()
        },
      },
      "options":{
        "page":page?.nextPage ?? 0,
        "limit": 20,
        "sort": {
          "date_utc": "desc"
        },
      }
    };
    if (searchText != null && searchText != '') {
      data["query"]["\$text"] = {
        "\$search": searchText,
      };
    }
    if (rocket != null) {
      data["query"]["rocket"] = rocket.id;
    }
    var response = await http.post(url, body: jsonEncode(data),
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