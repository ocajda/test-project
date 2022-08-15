import 'package:flutter/material.dart';

class PlaceholderLoadingData extends StatelessWidget {

  const PlaceholderLoadingData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.black
        ),
      ),
    );
  }
}
