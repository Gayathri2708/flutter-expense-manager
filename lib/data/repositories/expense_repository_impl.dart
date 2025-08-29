import 'package:expense_manager/core/error/failures.dart';
import 'package:expense_manager/data/datasources/local_database.dart';
import 'package:expense_manager/data/models/expense_model.dart';
import 'package:expense_manager/domain/entities/expense.dart';
import 'package:expense_manager/domain/repositories/expense_repository.dart';
import 'package:dartz/dartz.dart';

class ExpenseRepositoryImpl extends ExpenseRepository {
  final LocalDatabase localDatabase;

  ExpenseRepositoryImpl({required this.localDatabase});
  @override
  Future<Either<Failure, void>> addExpense(Expense expense) async {
    try {
      final expenseModel = ExpenseModel.fromEntity(expense);
      await localDatabase.insertExpense(expenseModel);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(String id) async {
    try {
      await localDatabase.deleteExpense(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Expense>>> getAllExpenses() async {
    try {
      final expenses = await localDatabase.getAllExpenses();
      return Right(expenses);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateExpense(Expense expense) async {
    try {
      final expenseModel = ExpenseModel.fromEntity(expense);
      await localDatabase.updateExpense(expenseModel);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
  
}