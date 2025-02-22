
class GoalsModel {
  final String userid;
  final String name;
  final String notes;
  final String divisa;
  final int category;
  final int ammount;
  final int? accumulatedAmount;
  final String? id;

  GoalsModel({
    required this.userid,
    required this.name,
    required this.notes,
    required this.category,
    required this.ammount,
    required this.divisa,
    this.accumulatedAmount,
    this.id,
  });

  factory GoalsModel.fromJson(Map<String, dynamic> json) {
    return GoalsModel(
      id: json['id'],
      userid: json['userid'],
      name: json['name'],
      notes: json['notes'],
      divisa: json['divisa'],
      category: json['category'],
      ammount: json['ammount'],
      accumulatedAmount: json['accumulatedAmount']
    );
  }

  Map<String,dynamic> toJson() {
    return {
      "id": id,
      "userid": userid,
      "name": name,
      "divisa": divisa,
      "notes": notes,
      "category": category,
      "ammount": ammount,
      "accumulatedAmount": accumulatedAmount
    };
  }

}