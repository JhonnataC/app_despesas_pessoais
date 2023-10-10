import 'dart:convert';

import 'package:projeto_despesas_pessoais/models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

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