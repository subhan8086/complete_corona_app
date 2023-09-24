import 'package:covid_app/modal/covid_model.dart';
import 'package:covid_app/services/stats_services.dart';
import 'package:covid_app/view/country_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:pie_chart/pie_chart.dart';

class worldstats extends StatefulWidget {
  const worldstats({super.key});

  @override
  State<worldstats> createState() => _worldstatsState();
}

class _worldstatsState extends State<worldstats> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

///////////////colors code/////////
  ///
  final colorList = <Color>[
    const Color(0xFF0000FF),
    const Color(0xFF00FF00),
    const Color(0xFFFF0000),
    const Color(0xFFFFD700),
    const Color(0xFFFFFFFF),
  ];
  @override
  Widget build(BuildContext context) {
    statservices Statservices = statservices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            FutureBuilder(
                future: Statservices.fetchstats(),
                builder: (context, AsyncSnapshot<covid_model> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          chartRadius: MediaQuery.of(context).size.width /
                              3.2, //for size of pie chart
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left),

                          // data on left sdie of chart
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recover": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Deaths":
                                double.parse(snapshot.data!.deaths.toString()),
                            "Active":
                                double.parse(snapshot.data!.active.toString()),
                            "TodayCases": double.parse(
                                snapshot.data!.todayCases.toString()),
                          }, //pie chart data
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring, //disc //pie chart style
                          colorList:
                              colorList, //colors of pie chart that we add in list on line 25
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .05),
                          child: Card(
                            child: Expanded(
                              child: Column(
                                children: [
                                  reuseablerow(
                                    title: 'Total',
                                    value: snapshot.data!.cases.toString(),
                                  ),
                                  reuseablerow(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered.toString(),
                                  ),
                                  reuseablerow(
                                    title: 'Death',
                                    value: snapshot.data!.deaths.toString(),
                                  ),
                                  reuseablerow(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString()),
                                  reuseablerow(
                                      title: 'TodayCases',
                                      value:
                                          snapshot.data!.todayCases.toString()),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    thickness: 5,
                                  ),
                                  SizedBox(
                                    height: 80,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  countrieslist()));
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF00FF00),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child:
                                          Center(child: Text('Track Country')),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }),
          ],
        ),
      )),
    );
  }
}

class reuseablerow extends StatelessWidget {
  String title, value;
  reuseablerow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          )
        ],
      ),
    );
  }
}
