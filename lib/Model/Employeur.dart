class Employeur{
  String nomEntreprise;
  String logo;

  Employeur({
    this.nomEntreprise,
    this.logo
  });

  factory Employeur.fromJson(Map<String, dynamic> json){
    return Employeur(
        nomEntreprise: json['nomEntreprise'],
        logo: json['logo']
    );
  }
}