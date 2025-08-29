import 'package:expense_manager/core/error/failures.dart';
import 'package:expense_manager/domain/entities/expense.dart';
import 'package:dartz/dartz.dart';

abstract class ExpenseRepository {
  Future<Either<Failure, List<Expense>>> getAllExpenses();
  Future<Either<Failure, void>> addExpense(Expense expense);
  Future<Either<Failure, void>> updateExpense(Expense expense);
  Future<Either<Failure, void>> deleteExpense(String id);
}