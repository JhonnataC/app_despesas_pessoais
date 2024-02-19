import 'package:flutter/foundation.dart';
import 'package:projeto_despesas_pessoais/data/transactions_history_storage.dart';

class TransactionsHistoryProvider with ChangeNotifier {
  List<Map<String, dynamic>> _transactionsHistory = [];

  List<Map<String, dynamic>> get history => [..._transactionsHistory];

  Future<void> loadTransactionsHistory() async {
    _transactionsHistory =
        await TransactionsHistoryStorage.getTransactionHistory();
    notifyListeners();
  }

  Future<void> clearTransactionsHistory() async {
    TransactionsHistoryStorage.clearTransactionsHistory();
    notifyListeners();
  }
}
