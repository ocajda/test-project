
class RocketClass  {

  String? id;
  String? name;
  String? country;
  String? description;
  String? company;
  String? firstFlight;
  num? height;
  num? mass;
  List<String>? images;

  RocketClass({
    this.id,
    this.name,
    this.country,
    this.description,
    this.company,
    this.firstFlight,
    this.height,
    this.mass,
    this.images,
  });

  factory RocketClass.fromJson(Map<String, dynamic> json) {
    return RocketClass(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      description: json['description'],
      company: json['company'],
      firstFlight: json['first_flight'],
      height: json['height']?['meters'],
      mass: json['mass']?['kg'],
      images: json["flickr_images"] != null 
          ? (json["flickr_images"] as List<dynamic>).map((image) => image.toString()).toList()
          : null,
    );
  }

  String getName() {
    return name ?? "";
  }

  String getCountry() {
    return country ?? "";
  }

  String getDescription() {
    return description ?? "";
  }

  String getCompany() {
    return company ?? "";
  }

  String getFirstFlight() {
    return firstFlight ?? "";
  }

  bool hasGallery() {
    return images != null;
  }
  

  @override
  String toString() => 'RocketClass(id: $id, name: $name)';
}
