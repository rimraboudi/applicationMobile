import 'package:firebase_database/firebase_database.dart';

class Activite {
  final String id;
  String nom;
  String description;
  String lieu;
  String duree;
  String date;
  String heureDebut;
  String type;

  Activite({this.id,this.nom, this.description, this.lieu, this.duree,
    this.date, this.heureDebut,this.type });

  Activite.fromSnapshot(DataSnapshot snapshot) :
        id = snapshot.key,
        nom = snapshot.value["nom"],
        description = snapshot.value["description"],
        lieu = snapshot.value["lieu"],
        duree = snapshot.value["duree"],
        date = snapshot.value["date"],
        heureDebut  = snapshot.value["heureDebut"],
        type  = snapshot.value["type"];

  toJson() {
    return {
      "libelle": nom,
      "description": description,
      "lieu": lieu,
      "duree":duree,
      "date":date,
      "heureDebut":heureDebut,
      "type":type,
    };
  }

}