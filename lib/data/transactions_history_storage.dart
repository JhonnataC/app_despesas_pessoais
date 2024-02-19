import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:projeto_despesas_pessoais/data/transaction_storage.dart';
import 'package:projeto_despesas_pessoais/models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionsHistoryStorage {
  static const _transactionHistoryKey = 'history';

  static Future<void> saveTransactionHistory() async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, List<Map<String, dynamic>>> historyTransactions = await history;

    final encodedJson = jsonEncode(historyTransactions);
    await prefs.setString(_transactionHistoryKey, encodedJson);
  }

  static Future<List<Map<String, dynamic>>> getTransactionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedJson = prefs.getString(_transactionHistoryKey);

    List<Map<String, dynamic>> historyTransactions = [];

    if (encodedJson != null) {
      final Map<String, dynamic> decodedJson = jsonDecode(encodedJson);

      decodedJson.forEach((dateKey, transactions) {
        historyTransactions.add({
          'data': dateKey,
          'transactions': transactions
              .map((transaction) => Transaction.fromMap(transaction))
              .toList(),
        });
      });
      return historyTransactions;
    } else {
      return [];
    }
  }

  static Future<void> clearTransactionsHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_transactionHistoryKey, jsonEncode({}));
  }

  static Future<Map<String, List<Map<String, dynamic>>>> get history async {
    final List<Transaction> transactions =
        await TransactionStorage.getTransactions();
    Map<String, List<Map<String, dynamic>>> historyMaps = {};

    if (transactions.isEmpty) return {};

    for (var transaction in transactions) {
      final date = DateFormat('MMMM, y', 'pt_BR').format(transaction.date);

      if (historyMaps.isEmpty) {
        historyMaps.addAll({
          date: [transaction.toMap()],
        });
        continue;
      }

      final copyHistory = historyMaps.keys.toList();

      for (var dateKey in copyHistory) {
        if (copyHistory.contains(date)) {
          if (dateKey == date) {
            historyMaps[date]!.add(transaction.toMap());
          }
        } else {
          historyMaps.addAll({
            date: [transaction.toMap()],
          });
        }
      }
    }

    return historyMaps;
  }
}
