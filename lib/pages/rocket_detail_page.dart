import 'package:flutter/material.dart';
import 'package:test/classes/rocket_class.dart';

class RocketDetailPage extends StatefulWidget {
  final RocketClass rocket;
  const RocketDetailPage({
    Key? key, 
    required this.rocket
  }) : super(key: key);

  @override
  State<RocketDetailPage> createState() => _RocketDetailPageState();
}

class _RocketDetailPageState extends State<RocketDetailPage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rocket.getName()),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Company"),
              Text(
                widget.rocket.getCompany(),
              ),
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "First flight"
              ),
              Text(widget.rocket.getFirstFlight()),
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             const  Text(
                "Country"
              ),
              Text(widget.rocket.getCountry()),
            ],
          ),
          const SizedBox(height: 16,),
          Text(widget.rocket.getDescription()),
          const SizedBox(height: 16,),
          if (widget.rocket.hasGallery())
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.rocket.images!.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16,),
                itemBuilder: (context, index) {
                  return Image.network(widget.rocket.images![index]);
                },
              ),
            )
        ],

      )
    );
  }
}