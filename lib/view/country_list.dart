import 'package:covid_app/services/stats_services.dart';
import 'package:covid_app/view/detail.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class countrieslist extends StatefulWidget {
  const countrieslist({super.key});

  @override
  State<countrieslist> createState() => _countrieslistState();
}

class _countrieslistState extends State<countrieslist> {
  TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    statservices Statservices = statservices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _search,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: Statservices.countrylist(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            //////////////////////////////////////////////////////
                            if (_search.text.isEmpty) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => detailscreen(
                                                name: snapshot.data![index]
                                                    ['country'],
                                                image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                todayCases: snapshot
                                                    .data![index]['cases'],
                                                deaths: snapshot.data![index]
                                                    ['deaths'],
                                                recovered: snapshot.data![index]
                                                    ['recovered'],
                                                population: snapshot
                                                    .data![index]['population'],
                                                active: snapshot.data![index]
                                                    ['active'],
                                                critical: snapshot.data![index]
                                                    ['critical'],
                                              )));
                                },
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    detailscreen(
                                                      name:
                                                          snapshot.data![index]
                                                              ['country'],
                                                      image: snapshot
                                                                  .data![index]
                                                              ['countryInfo']
                                                          ['flag'],
                                                      todayCases:
                                                          snapshot.data![index]
                                                              ['cases'],
                                                      deaths:
                                                          snapshot.data![index]
                                                              ['deaths'],
                                                      recovered:
                                                          snapshot.data![index]
                                                              ['recovered'],
                                                      population:
                                                          snapshot.data![index]
                                                              ['population'],
                                                      active:
                                                          snapshot.data![index]
                                                              ['active'],
                                                      critical:
                                                          snapshot.data![index]
                                                              ['critical'],
                                                    )));
                                      },
                                      child: ListTile(
                                        title: Text(
                                          snapshot.data![index]['country'],
                                        ),
                                        subtitle: Text(
                                          snapshot.data![index]['cases']
                                              .toString(),
                                        ),
                                        leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                    ['countryInfo']['flag'])),
                                      ),
                                    )
                                  ],
                                ),
                              );
                              /////////////////////////
                            } else if (name
                                .toLowerCase()
                                .contains(_search.text.toLowerCase())) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      snapshot.data![index]['country'],
                                    ),
                                    subtitle: Text(
                                      snapshot.data![index]['cases'].toString(),
                                    ),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag'])),
                                  )
                                ],
                              );
                              ////////////////////////////
                            } else {
                              return Container();
                            }
                          });
                    }
                  }))
        ],
      )),
    );
  }
}
