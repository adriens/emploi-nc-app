class Favory {
  int id;
  String shortnumeroOffre;

  Favory({
    this.id,
    this.shortnumeroOffre,
  });

  factory Favory.fromJson(Map<String, dynamic> json) {
    return Favory(
      id: json["id"],
      shortnumeroOffre: json["shortnumeroOffre"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shortnumeroOffre': shortnumeroOffre,
    };
  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "shortnumeroOffre": shortnumeroOffre,

  };
}