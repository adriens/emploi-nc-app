import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:EmploiNC/Model/Emploi.dart';
import 'package:EmploiNC/app_config.dart';

const Map<String, String> HEADERS = {
  'x-rapidapi-key': apiKey,
  'Content-type': 'application/json; charset=utf-8'
};

class EmploiService {

  static Future<List<Emploi>> getLatestEmplois(String nb) async{
      var response = await http.get(
          'https://emploi-nouvelle-caledonie.p.rapidapi.com/emploi/latest/' + nb,
          headers: HEADERS);
      print("Status : " + response.statusCode.toString());
      print("URL <" + response.request.toString() + ">");
      print("Reponse 1<" + response.body + ">");
      Iterable i = json.decode(utf8.decode(response.bodyBytes));

      List<Emploi> latestEmplois = i.map((data) => Emploi.fromJson(data)).toList();
      print("latestEmplois<" + latestEmplois[0].titreOffre + ">");
      return latestEmplois;

  }

  static Future<List<Emploi>> getSearch(String nb,String search,String commune,String contrat,String datedebut, String datefin) async{

    try{
      datedebut = datedebut.replaceAll("/", "");
      datefin = datefin.replaceAll("/", "");
      print(datedebut+"|"+datefin);
      if ( commune.contains("Tout")) commune = "none";
      if ( contrat.contains("Tout")) contrat = "none";
      if ( search.isEmpty || search == "" || search == null ) search = "none";

      if ( datedebut.isEmpty || datefin.isEmpty )  {datedebut = "none";datefin = "none";}
      var response= await http.get('https://emploi-nouvelle-caledonie.p.rapidapi.com/search/'+nb+"/"+search+"/"+commune+"/"+contrat+"/"+datedebut+"/"+datefin, headers : HEADERS );

      print("Status : "+response.statusCode.toString() );
      print("URL <"+response.request.toString()+">");
      print("Reponse 1<"+response.body+">");
      Iterable i = json.decode(utf8.decode(response.bodyBytes));

      List<Emploi> latestEmplois = i.map((data) => Emploi.fromJson(data)).toList();
      print("latestEmplois<"+latestEmplois[0].titreOffre+">");
      return latestEmplois;
    }catch(RangeError){
      return null;
    }
  }
}