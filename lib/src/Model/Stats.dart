
class Stats {

  String nbOffresPublieesTotales;
  String nbOffresPublieesEnCours;
  String nbEmployeursAvecOffresPubliees;

  Stats({
    this.nbOffresPublieesTotales,
    this.nbOffresPublieesEnCours,
    this.nbEmployeursAvecOffresPubliees,
  });

  factory Stats.fromJson(Map<String, dynamic> json) =>
      new Stats(
          nbOffresPublieesTotales: json['nbOffresPublieesTotales'],
          nbOffresPublieesEnCours: json['nbOffresPublieesEnCours'],
          nbEmployeursAvecOffresPubliees: json['nbEmployeursAvecOffresPubliees'],
      );

}