import 'package:expense_manager/domain/entities/expense.dart';

class ExpenseModel extends Expense {
  const ExpenseModel({
    required String id,
    required String title,
    required double amount,
    required String category,
    required DateTime date,
    String? description,
  }) : super(
          id: id,
          title: title,
          amount: amount,
          category: category,
          date: date,
          description: description,
        );

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
        id: json['id'],
        title: json['title'],
        amount: json['amount'].toDouble(),
        category: json['category'],
        date: DateTime.fromMicrosecondsSinceEpoch(json['date']),
        description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.millisecondsSinceEpoch,
      'description': description
    };
  }

  factory ExpenseModel.fromEntity(Expense enpense) {
    return ExpenseModel(
        id: enpense.id,
        title: enpense.title,
        amount: enpense.amount,
        category: enpense.category,
        date: enpense.date);
  }
}
