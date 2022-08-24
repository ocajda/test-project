import 'package:flutter/material.dart';

class ListDivider extends StatelessWidget {


  const ListDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 1, 
      color: Colors.black.withOpacity(0.3)
    );
  }
}
