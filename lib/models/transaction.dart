class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;
  final String categoryValue;

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.date,
    required this.categoryValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'value': value,
      'date': date.toIso8601String(),
      'category': categoryValue,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      title: map['title'],
      value: map['value'],
      date: DateTime.parse(map['date']),
      categoryValue: map['category'],
    );
  }
}