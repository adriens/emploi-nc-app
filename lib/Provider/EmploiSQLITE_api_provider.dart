import 'package:EmploiNC/Model/EmploiSQLITE.dart';

import 'DBProvider.dart';
import 'package:http/http.dart' as http;
import 'package:EmploiNC/app_config.dart';
import 'package:dio/dio.dart';

const Map<String, String> HEADERS = {
  'x-rapidapi-key': apiKey,
  'Content-type': 'application/json; charset=utf-8'
};

class EmploiSQLITEApiProvider {
  Future<List<EmploiSQLITE>> getAllEmploiSQLITE(nb) async {
    var url ='https://emploi-nouvelle-caledonie.p.rapidapi.com/emploi/latest/'+nb;
    Response response = await Dio().get(
      url,
      options: Options(
        headers: {
          'x-rapidapi-key': apiKey,
          'Content-type': 'application/json; charset=utf-8'
        },
      )
    );

    return (response.data as List).map((emploi) {
      print('Inserting $emploi');
      DBProvider.db.createEmploi(EmploiSQLITE.fromJson(emploi));
    }).toList();
  }
}