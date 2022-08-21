import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LaunchClass  {

  String? id;
  String? name;
  int? flightNumber;
  String? dateUtc;
  bool? upcoming;
  bool? success;
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
    this.success,
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
      success: json['success'],
      rocketId: json['rocket'],
      details: json['details'],
      smallImage: json['links']?['patch']?['small'],
      largeImage: json['links']?['patch']?['large'],
    );
  }

  String getSmallImage() {
    return smallImage ?? 'https://via.placeholder.com/300';
  }

  String getName() {
    return name ?? "";
  }

  IconData getLaunchIcon() {
    if (upcoming != false) {
      return Icons.rocket;
    }
    switch (success) {
      case true:
        return Icons.check;
      case false:
        return Icons.clear;
      default:
        return Icons.check;
    }
  }

  Color getLaunchColor() {
    if (upcoming != false) {
      return Colors.black;
    }
    switch (success) {
      case true:
        return Colors.green;
      case false:
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  bool hasSuccessLaunch() {
    return success ?? false;
  }

  bool isUpcomming() {
    return upcoming ?? false;
  }

  String getDate() {
    if (dateUtc != null) {
      DateTime parsedDate = DateTime.parse(dateUtc!);
      DateTime date = DateTime.utc(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        parsedDate.hour,
        parsedDate.minute,
        parsedDate.second
      ).toLocal();
      return DateFormat("dd-MMM-yyyy HH:mm").format(date);
    }
    return "";
  }

  
  

  @override
  String toString() => 'LaunchClass(id: $id, name: $name, smallImage: $smallImage, largeImage: $largeImage)';
}
