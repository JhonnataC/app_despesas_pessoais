import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'value': value,
      'date': date.toIso8601String(),
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      title: map['title'],
      value: map['value'],
      date: DateTime.parse(map['date']),
    );
  }
}

class TransactionStorage {
  static const String _transactionsKey = 'transactions';

  Future<List<Transaction>> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final transactionsJson = prefs.getString(_transactionsKey);
    if (transactionsJson != null) {
      final List<dynamic> decodedJson = jsonDecode(transactionsJson);
      final transactions = decodedJson
          .map((transactionJson) => Transaction.fromMap(transactionJson))
          .toList();
      return transactions;
    }
    return [];
  }

  Future<void> saveTransactions(List<Transaction> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedJson = jsonEncode(
      transactions.map((transaction) => transaction.toMap()).toList(),
    );
    await prefs.setString(_transactionsKey, encodedJson);
  }
}
