import 'package:EmploiNC/src/Model/EmploiSQLITE.dart';
import 'package:EmploiNC/src/Model/Favory.dart';

import 'DBProvider.dart';
import 'package:EmploiNC/src/app_config.dart';
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
      DBProvider.db.createEmploi(EmploiSQLITE.fromJson(emploi));
    }).toList();
  }

  Future<List<EmploiSQLITE>> getNextXEmploiSQLITE(nb,numeroOffre) async {
    var url ='https://emploi-nouvelle-caledonie.p.rapidapi.com/emploi/next/'+nb+'/'+numeroOffre;
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
      DBProvider.db.createEmploi(EmploiSQLITE.fromJson(emploi));
    }).toList();
  }

  Future<List<EmploiSQLITE>> getPREVIOUSXEmploiSQLITE(nb,numeroOffre) async {
    var url ='https://emploi-nouvelle-caledonie.p.rapidapi.com/emploi/previous/'+nb+'/'+numeroOffre;
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
      DBProvider.db.createEmploi(EmploiSQLITE.fromJson(emploi));
    }).toList();
  }

  bool favOffer(Favory fav) {
    try{
      DBProvider.db.createFavory(fav);
      return true;
    }catch(Error){
      return false;
    }
  }
}