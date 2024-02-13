import 'dart:convert';

import 'package:projeto_despesas_pessoais/models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionStorage {
  static const String _transactionsKey = 'transactions';

  static Future<void> saveTransactions(List<Transaction> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedJson = jsonEncode(
      transactions.map((transaction) => transaction.toMap()).toList(),
    );
    await prefs.setString(_transactionsKey, encodedJson);
    TransactionsHistoryStorage.saveHistory();
  }

  static Future<List<Transaction>> getTransactions() async {
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
}

class TransactionsHistoryStorage {
  static const _transactionHistoryKey = 'history';

  static Future<void> saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Transaction> monthTransactions =
        await TransactionStorage.getTransactions();

    // if (monthTransactions.isEmpty) return;

    if (monthTransactions.isEmpty) {
      await prefs.setString(_transactionHistoryKey, jsonEncode([[]]));
      print('limpo');
      return;
    }

    final currentMonth = monthTransactions.first.date.month;

    List<List<Transaction>> historyTransactions = await getTransactionHistory();

    print(historyTransactions);

    if (historyTransactions.first.isEmpty) {
      historyTransactions[0] = monthTransactions;
      print('empty');
    } else {
      // for (var i = 0; i < historyTransactions.length; i++) {
      //   for (var j = 0; j < historyTransactions[i].length; j++) {
      //     if (historyTransactions[i][j].date.month == currentMonth) {
      //       historyTransactions[i] = monthTransactions;
      //       print('if');
      //     } else {
      //       historyTransactions.add(monthTransactions);
      //       print('else');
      //     }
      //   }
      // }

      for (var listTransactions in historyTransactions) {
        print(listTransactions.first.date.month);
        for (var transaction in listTransactions) {
          if (transaction.date.month == currentMonth) {
            final index = historyTransactions.indexOf(listTransactions);
            print(index);
            historyTransactions[index] = monthTransactions;
            break;
          } else {
            print('else');
            historyTransactions.add(monthTransactions);
          }
        }
      }
    }

    var historyTransactionsEncoded = [];
    var monthTransactionsEncoded = [];

    for (var monthTransactions in historyTransactions) {
      monthTransactionsEncoded.clear();
      for (var transaction in monthTransactions) {
        monthTransactionsEncoded.add(transaction.toMap());
      }
      historyTransactionsEncoded.add([...monthTransactionsEncoded]);
    }

    final encodedJson = jsonEncode(historyTransactionsEncoded);
    await prefs.setString(_transactionHistoryKey, encodedJson);
  }

  static Future getTransactionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonEncoded = prefs.getString(_transactionHistoryKey);
    List<List<Transaction>> historyTransactions = [];
    List<Transaction> monthTransactions = [];

    if (jsonEncoded != null) {
      final List<dynamic> jsonDecoded = jsonDecode(jsonEncoded);

      // dividir o historico por mes aqui

      for (var monthsDecoded in jsonDecoded) {
        monthTransactions.clear();
        for (var transaction in monthsDecoded) {
          monthTransactions.add(Transaction.fromMap(transaction));
        }
        historyTransactions.add([...monthTransactions]);
      }

      return historyTransactions;
    } else {
      return;
    }
  }
}
