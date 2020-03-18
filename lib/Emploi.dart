import 'dart:convert';

class Emploi {

  String titreOffre;

  Emploi({
    this.titreOffre
  });

  factory Emploi.fromJson(Map<String, dynamic> json) =>
    new Emploi(
      titreOffre: json['titreOffre']
    );
}