import 'package:cloud_firestore/cloud_firestore.dart';

enum TypeLevel {
  beginner,
  intermediate,
  advanced,
}

class AtributeProfile {
  final String userid;
  final int energy;
  final int guias;
  final int lectures;
  final TypeLevel typeLevel;

  AtributeProfile({
    required this.userid,
    required this.energy,
    required this.guias,
    required this.lectures,
    required this.typeLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'iduser': userid,
      'energy': energy,
      'guias': guias,
      'lectures': lectures,
      'type_level': typeLevel.name,
    };
  }

  factory AtributeProfile.fromJson(Map<String, dynamic> json) {
    return AtributeProfile(
      userid: json['userid'] as String,
      energy: json['energy'] as int,
      guias: json['guias'] as int,
      lectures: json['lectures'] as int,
      typeLevel: json['type_level'] ?? TypeLevel.beginner,
    );
  }

  factory AtributeProfile.fromQuery(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final Map<String, dynamic> json = snapshot.data();
    return AtributeProfile.fromJson(json);
  }

}