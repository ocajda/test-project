import 'package:flutter/material.dart';

class PlaceholderNoData extends StatelessWidget {
  const PlaceholderNoData({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      child: Text(
        "No available data",
        style: TextStyle(
          color: Colors.black
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
