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

    var response= await http.get('https://emploi-nouvelle-caledonie.p.rapidapi.com/emploi/latest/'+nb, headers : HEADERS );
      print("Status : "+response.statusCode.toString() );
      print("URL <"+response.request.toString()+">");
      print("Reponse 1<"+response.body+">");
      Iterable i = json.decode(utf8.decode(response.bodyBytes));

      List<Emploi> latestEmplois = i.map((data) => Emploi.fromJson(data)).toList();
      print("latestEmplois<"+latestEmplois[0].titreOffre+">");
      return latestEmplois;
  }

  static Future<List<Emploi>> getSearch(String nb,String search,String commune,String contrat,DateTime datedebut, DateTime datefin) async{

    String day_date1 = "0";
    String day_date2 = "0";
    String month_date1 = "0";
    String month_date2 = "0";

    datedebut.day.toString().length == 2 ? day_date1 =  datedebut.day.toString() : day_date1 = day_date1 + datedebut.day.toString();
    datefin.day.toString().length == 2 ? day_date2 =  datefin.day.toString() : day_date2 = day_date2 + datefin.day.toString();
    datedebut.month.toString().length == 2 ? month_date1 =  datedebut.month.toString() : month_date1 = month_date1 + datedebut.month.toString();
    datefin.month.toString().length == 2 ? month_date2 =  datefin.month.toString() : month_date2 = month_date2 + datefin.month.toString();

    String date1 = day_date1+month_date1+datedebut.year.toString();
    String date2 = day_date2+month_date2+datefin.year.toString();
    if ( commune.contains("Tout")) commune = "none";
    if ( contrat.contains("Tout")) contrat = "none";
    if ( search.isEmpty || search == "" || search == null ) search = "none";

    if ( datedebut.isAfter(datefin) )  date1 = "none";date2 = "none";
    var response= await http.get('https://emploi-nouvelle-caledonie.p.rapidapi.com/search/'+nb+"/"+search+"/"+commune+"/"+contrat+"/"+date1+"/"+date2, headers : HEADERS );

    print("Status : "+response.statusCode.toString() );
    print("URL <"+response.request.toString()+">");
    print("Reponse 1<"+response.body+">");
    Iterable i = json.decode(utf8.decode(response.bodyBytes));

    List<Emploi> latestEmplois = i.map((data) => Emploi.fromJson(data)).toList();
    print("latestEmplois<"+latestEmplois[0].titreOffre+">");
    return latestEmplois;
  }
}