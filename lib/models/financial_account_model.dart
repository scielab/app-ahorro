


class BudgetAccountModel {
  final String? id;
  final String userid;
  final String name;
  final int ammount;
  final String accountType;
  final String notes;

  BudgetAccountModel({
    this.id,
    required this.userid,
    required this.name,
    required this.ammount,
    required this.accountType,
    required this.notes,
  });

  // COMPROBAR QUE ESTO ESTE FUNCIONANDO CORRECTAMENTE
  factory BudgetAccountModel.fromJson(Map<String, dynamic> json) {
    return BudgetAccountModel(
      id: json['id'],
      userid: json['userid'],
      name: json['name'],
      ammount: json['amount'],
      accountType: json['accountType'],
      notes: json['notes'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userid": userid,
      "name": name,
      "amount": ammount,
      "accountType": accountType,
      "notes": notes,
    };
  }
}

// enum AccountType {
//   MasterCard,
//   Wallet,
//   Cash,
//   Cryptocurrencies,
//   Unknown, // Por defecto en caso de error
// }