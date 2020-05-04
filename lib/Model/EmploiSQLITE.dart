import 'dart:convert';

List<EmploiSQLITE> employeeFromJson(String str) =>
    List<EmploiSQLITE>.from(json.decode(str).map((x) => EmploiSQLITE.fromJson(x)));

String employeeToJson(List<EmploiSQLITE> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmploiSQLITE {
  int id;
  String titreOffre;

  EmploiSQLITE({
    this.id,
    this.titreOffre,
  });

  factory EmploiSQLITE.fromJson(Map<String, dynamic> json) => EmploiSQLITE(
    id: json["id"],
    titreOffre: json["titreOffre"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "titreOffre": titreOffre,
  };
}