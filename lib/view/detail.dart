import 'package:covid_app/view/world_stats.dart';
import 'package:flutter/material.dart';

class detailscreen extends StatefulWidget {
  String name;
  String image;
  int todayCases, deaths, recovered, population, active, critical;
  detailscreen(
      {super.key,
      required this.name,
      required this.image,
      required this.todayCases,
      required this.deaths,
      required this.recovered,
      required this.population,
      required this.active,
      required this.critical});

  @override
  State<detailscreen> createState() => _detailscreenState();
}

class _detailscreenState extends State<detailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      reuseablerow(
                          title: 'Cases', value: widget.todayCases.toString()),
                      reuseablerow(
                          title: 'Deaths', value: widget.deaths.toString()),
                      reuseablerow(
                          title: 'Recovered',
                          value: widget.recovered.toString()),
                      reuseablerow(
                          title: 'Population',
                          value: widget.population.toString()),
                      reuseablerow(
                          title: 'Active', value: widget.active.toString()),
                      reuseablerow(
                          title: 'Critical', value: widget.critical.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
