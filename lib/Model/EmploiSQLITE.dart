import 'dart:convert';

import 'Employeur.dart';

List<EmploiSQLITE> employeeFromJson(String str) =>
    List<EmploiSQLITE>.from(json.decode(str).map((x) => EmploiSQLITE.fromJson(x)));

String employeeToJson(List<EmploiSQLITE> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmploiSQLITE {
  int id;
  String titreOffre;
  Employeur employeur;
  String datePublication;
  String typeContrat;
  String aPourvoirLe;
  String communeEmploi;
  String url;

  EmploiSQLITE({
    this.id,
    this.titreOffre,
    this.datePublication,
    this.employeur,
    this.typeContrat,
    this.aPourvoirLe,
    this.communeEmploi,
    this.url
  });


  factory EmploiSQLITE.fromJson(Map<String, dynamic> json) {
    return EmploiSQLITE(
      id: json["id"],
      datePublication: json["datePublication"],
      titreOffre: json['titreOffre'],
      typeContrat: json['typeContrat'],
      employeur : Employeur.fromJson(json["employeur"]),
      aPourvoirLe: json['aPourvoirLe'],
      communeEmploi : json['communeEmploi'],
      url: json['url']
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "titreOffre": titreOffre,
    "typeContrat": typeContrat,
    "datePublication":datePublication,
    "nomEntreprise":  employeur.nomEntreprise,
    "logo": employeur.logo,
    "aPourvoirLe": aPourvoirLe,
    "communeEmploi": communeEmploi,
    "url": url,
  };
}