import 'dart:convert';

import 'package:covid_app/modal/covid_model.dart';
import 'package:covid_app/services/utilties/app_urls.dart';
import 'package:http/http.dart' as http; //used to fetch data from api

class statservices {
  //////use for world stats////////hit
  Future<covid_model> fetchstats() async {
    final response = await http.get(Uri.parse(appurl.worldstateApi1));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return covid_model.fromJson(data);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

//////////////use for country list//////////hit
  // Future<List<dynamic>> countrylist() async {
  //   var data;
  //   final response = await http.get(Uri.parse(appurl.countrieslist));
  //   if (response.statusCode == 200) {
  //     data = jsonDecode(response.body);
  //     return data;
  //   } else {
  //     throw Exception('Error');
  //   }
  // }
  Future<List<dynamic>> countrylist() async {
    final response = await http.get(Uri.parse(appurl.countrieslist));

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      await Future.delayed(Duration(seconds: 5));
      return countrylist();
    }
  }
}
