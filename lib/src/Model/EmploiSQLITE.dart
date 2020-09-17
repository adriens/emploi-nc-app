import 'dart:convert';

import 'Employeur.dart';

List<EmploiSQLITE> employeeFromJson(String str) =>
    List<EmploiSQLITE>.from(json.decode(str).map((x) => EmploiSQLITE.fromJson(x)));

String employeeToJson(List<EmploiSQLITE> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmploiSQLITE {
  int id;
  String shortnumeroOffre;
  String titreOffre;
  Employeur employeur;
  String datePublication;
  String typeContrat;
  String aPourvoirLe;
  String communeEmploi;
  String url;
  String isFav;

  EmploiSQLITE({
    this.id,
    this.isFav,
    this.titreOffre,
    this.shortnumeroOffre,
    this.datePublication,
    this.employeur,
    this.typeContrat,
    this.aPourvoirLe,
    this.communeEmploi,
    this.url,
  });


  factory EmploiSQLITE.fromJson(Map<String, dynamic> json) {
    return EmploiSQLITE(
      id: json["id"],
      isFav : "false",
      datePublication: json["datePublication"],
      shortnumeroOffre: json["shortnumeroOffre"],
      titreOffre: json['titreOffre'],
      typeContrat: json['typeContrat'],
      employeur : json["employeur"] != null ? Employeur.fromJson( json["employeur"]  ) : new Employeur(),
      aPourvoirLe: json['aPourvoirLe'],
      communeEmploi : json['communeEmploi'],
      url: json['url']
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "isFav":isFav,
    "titreOffre": titreOffre,
    "shortnumeroOffre":shortnumeroOffre,
    "typeContrat": typeContrat,
    "datePublication":datePublication,
    "nomEntreprise":  employeur.nomEntreprise,
    "logo": employeur.logo,
    "aPourvoirLe": aPourvoirLe,
    "communeEmploi": communeEmploi,
    "url": url,
  };
}