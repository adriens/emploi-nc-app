import 'dart:convert';

import 'package:EmploiNC/src/Model/Stats.dart';
import 'package:http/http.dart' as http;

import 'package:EmploiNC/src/app_config.dart';

const Map<String, String> HEADERS = {
  'x-rapidapi-key': apiKey,
  'Content-type': 'application/json; charset=utf-8'
};
class StatsService {

  static Future<Stats> getStats() async {

    print("StatsService : ");

    var response = await http.get('https://emploi-nouvelle-caledonie.p.rapidapi.com/stats',headers: HEADERS);
    print("Status : " + response.statusCode.toString());
    print("URL <" + response.request.toString() + ">");
    print("Reponse 1<" + response.body + ">");

    return Stats.fromJson(json.decode(response.body));
  }

}