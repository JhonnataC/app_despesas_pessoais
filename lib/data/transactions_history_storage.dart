import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:projeto_despesas_pessoais/models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionsHistoryStorage {
  static const _transactionHistoryKey = 'history';

  static String _dateFormated(DateTime date) {
    return DateFormat('MMMM, y', 'pt_BR').format(date);
  }

  static Future<void> saveTransactionHistory(
      Map<String, dynamic> transactionsHistory) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedJson = jsonEncode(transactionsHistory);
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
          'date': dateKey,
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

  static Future<void> addTransactionHistory(Transaction newTransaction) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedJson = prefs.getString(_transactionHistoryKey);
    final transactionDate = _dateFormated(newTransaction.date);
    Map<String, dynamic> transactions = {};

    if (encodedJson != null) {
      transactions = jsonDecode(encodedJson);

      if (transactions.containsKey(transactionDate)) {
        transactions[transactionDate].add(newTransaction.toMap());
      } else {
        transactions.addAll({
          transactionDate: [newTransaction.toMap()]
        });
      }
    } else {
      transactions.addAll({
        transactionDate: [newTransaction.toMap()]
      });
    }
    saveTransactionHistory(transactions);
  }

  static Future<void> removeTransactionHistory(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedJson = prefs.getString(_transactionHistoryKey);
    final currentDate = _dateFormated(DateTime.now());

    if (encodedJson != null) {
      Map<String, dynamic> transactionsHistory = jsonDecode(encodedJson);
      transactionsHistory.forEach((date, transactions) {
        if (date == currentDate) {
          transactions.removeWhere((tr) => tr['id'] == id);
        }
      });
      if (transactionsHistory[currentDate] != null &&
          transactionsHistory[currentDate].isEmpty) {
        transactionsHistory.remove(currentDate);
      }
      saveTransactionHistory(transactionsHistory);
    }
  }

  static Future<void> clearCurrentMonth() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedJson = prefs.getString(_transactionHistoryKey);
    final currentMonth = _dateFormated(DateTime.now());

    if (encodedJson != null) {
      Map<String, dynamic> transactions = jsonDecode(encodedJson);

      if (transactions[currentMonth] != null) {
        transactions.remove(currentMonth);
        saveTransactionHistory(transactions);
      }
    }
  }

  static Future<void> clearTransactionsHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_transactionHistoryKey, jsonEncode({}));
  }
}
