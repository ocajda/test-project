class LaunchClass  {

  String? id;
  String? name;
  int? flightNumber;
  String? dateUtc;
  bool? upcoming;
  String? rocketId;
  String? details;
  String? smallImage;
  String? largeImage;

  LaunchClass({
    this.id,
    this.name,
    this.flightNumber,
    this.dateUtc,
    this.upcoming,
    this.rocketId,
    this.details,
    this.smallImage,
    this.largeImage,
  });

  factory LaunchClass.fromJson(Map<String, dynamic> json) {
    return LaunchClass(
      id: json['id'],
      name: json['name'],
      flightNumber: json['flight_number'],
      dateUtc: json['date_utc'],
      upcoming: json['upcoming'],
      rocketId: json['rocket'],
      details: json['details'],
      smallImage: json['links']?['patch']?['small'],
      largeImage: json['links']?['patch']?['large'],
    );
  }

  String getSmallImage() {
    return smallImage ?? "";
  }

  String getName() {
    return name ?? "";
  }

  
  

  @override
  String toString() => 'LaunchClass(id: $id, name: $name, smallImage: $smallImage, largeImage: $largeImage)';
}
