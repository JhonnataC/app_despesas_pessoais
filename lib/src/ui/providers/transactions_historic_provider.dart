import 'package:flutter/foundation.dart';
import 'package:projeto_despesas_pessoais/src/data/services/transactions_history_service.dart';

class TransactionsHistoryProvider with ChangeNotifier {
  List<Map<String, dynamic>> _transactionsHistory = [];

  List<Map<String, dynamic>> get history {
    _transactionsHistory.sort(
      (a, b) =>
          a['transactions'].first.date.compareTo(b['transactions'].first.date),
    );
    return [..._transactionsHistory.reversed];
  }

  Future<void> loadTransactionsHistory() async {
    _transactionsHistory =
        await TransactionsHistoryService.getTransactionHistory();
    notifyListeners();
  }

  Future<void> clearTransactionsHistory() async {
    TransactionsHistoryService.clearTransactionsHistory();
    notifyListeners();
  }
}
