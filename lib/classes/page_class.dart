import 'package:test/classes/launch_class.dart';

class PageClass  {

  bool? hasNextPage;
  int? nextPage;
  List<LaunchClass>? launches;

  PageClass({
    this.hasNextPage,
    this.nextPage,
    this.launches,
  });

  factory PageClass.fromJson(Map<String, dynamic> json) {
    return PageClass(
      hasNextPage: json['hasNextPage'],
      nextPage: json['nextPage'],
      launches: json['docs'] != null
        ? (json['docs'] as List<dynamic>).map((launch) => LaunchClass
          .fromJson(launch)).toList()
        : null,
    );
  }

  
  

  @override
  String toString() => 'PageClass(hasNextPage: $hasNextPage)';
}
