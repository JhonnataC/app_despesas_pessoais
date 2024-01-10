import 'package:flutter/material.dart';

class CategoriesMapProvider with ChangeNotifier {
  // Map das categorias existentes
  final List<Map<String, Object>> categoriesMap = [
    {
      'title': 'Alimentos',
      'icon': const Icon(Icons.restaurant),
      'color': const Color(0XFFF8AB02),
      'transactionValue': '0',
    },
    {
      'title': 'Faturas',
      'icon': const Icon(Icons.attach_money),
      'color': const Color(0XFF01D99F),
      'transactionValue': '1',
    },
    {
      'title': 'Transporte',
      'icon': const Icon(Icons.emoji_transportation),
      'color': const Color(0XFF36B5EB),
      'transactionValue': '2',
    },
    {
      'title': 'Moradia',
      'icon': const Icon(Icons.house_rounded),
      'color': const Color(0XFF897AF1),
      'transactionValue': '3',
    },
    {
      'title': 'Outros',
      'icon': const Icon(Icons.more_outlined),
      'color': const Color(0XFFF43460),
      'transactionValue': '4',
    },
  ];
}
