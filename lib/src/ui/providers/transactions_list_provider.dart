import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_despesas_pessoais/src/data/services/transactions_service.dart';
import 'package:projeto_despesas_pessoais/src/data/services/transactions_history_service.dart';
import 'package:projeto_despesas_pessoais/src/domain/models/transaction.dart';

class TransactionsListProvider with ChangeNotifier {
  // _transactions é a lista das transações cadastradas no mês
  List<Transaction> _transactions = [];

  // Retorna a lista de transactions
  List<Transaction> get transactions => [..._transactions];

  // Retorna as transações do mês atual
  List<Transaction> get monthTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(
        DateTime.now().subtract(
          Duration(days: DateTime.now().day),
        ),
      );
    }).toList();
  }

  // Adiciona uma transação à _transactions
  void addTransaction(
      String title, double value, DateTime date, String categoryValue) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
      categoryValue: categoryValue,
    );
    _transactions.add(newTransaction);
    TransactionsService.saveTransactions(_transactions);
    TransactionsHistoryService.addTransactionHistory(newTransaction);
    notifyListeners();
  }

  // Traz as transações do BD para a variável _transactions
  void loadTransactions() async {
    _transactions = await TransactionsService.getTransactions();
    notifyListeners();
  }

  // Remove uma trasanção específica da lista _transactions
  void removeTransaction(String id) {
    _transactions.removeWhere((tr) => tr.id == id);
    TransactionsService.saveTransactions(_transactions);
    TransactionsHistoryService.removeTransactionHistory(id);
    notifyListeners();
  }

  // Remove todas as transações da lista _transactions
  void clearTransactions() {
    _transactions.clear();
    TransactionsService.saveTransactions(_transactions);
    TransactionsHistoryService.clearCurrentMonth();
    notifyListeners();
  }
}
