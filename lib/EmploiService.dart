import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Emploi.dart';

const Map<String, String> HEADERS = {
  'x-rapidapi-key': '9fde4c46a9mshe439586e7fd2280p17ab6ejsnbe1af0bb4192',
  'Content-type': 'application/json; charset=utf-8'
};

class EmploiService {
  static Future<List<Emploi>> getLatestEmplois() async{

    var response= await http.get('https://emploi-nouvelle-caledonie.p.rapidapi.com/emploi/latest', headers : HEADERS );
      print("Status : "+response.statusCode.toString() );
      print("URL <"+response.request.toString()+">");
      print("Reponse 1<"+response.body+">");
      Iterable i = json.decode(utf8.decode(response.bodyBytes));

      List<Emploi> latestEmplois = i.map((data) => Emploi.fromJson(data)).toList();
    print("latestEmplois<"+latestEmplois[0].titreOffre+">");
      return latestEmplois;
  }
}