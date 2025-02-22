import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionBase {
  final String id;
  final String title;
  final int amount;
  final DateTime date;
  final String type;
  final String userid;
  final int category;
  String? uid;

  TransactionBase({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.userid,
    required this.category,
    this.uid
  });

  Map<String,dynamic> toMap() {
    return {
      'id':id,
      'title': title,
      'amount': amount,
      'date': date,
      'type': type,
      'userid': userid,
      'category': category
    };
  }

  static TransactionBase transactionFromFirebase(Map<String, dynamic> data,String uid) {
    return TransactionBase(
      id: data['id'],
      title: data['title'] ?? '',
      amount: (data['amount'] ?? 0).toInt(),
      date: (data['date'] as Timestamp).toDate(),
      type: data['type'] ?? '',
      userid: data['userid'] ?? '',
      category: data['category'] ?? 0,
      uid: uid,
    );
  }
}


class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final int category;
  final String userid;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.userid,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date,
      'category': category,
      'userid': userid,
    };
  }
}
