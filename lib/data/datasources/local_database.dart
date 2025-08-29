import 'dart:async';

import 'package:expense_manager/data/models/expense_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class LocalDatabase {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'expense_manager.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE EXPENSES(
      id TEXT PRIMARY KEY,
      title TEXT NOT NULL,
      amount REAL NOT NULL,
      category TEXT NOT NULL,
      date INTEGER NOT NULL,
      description TEXT
    ) 
    ''');
  }

  // Insert expense
  Future<void> insertExpense(ExpenseModel expense) async {
    final db = await database;
    await db.insert('expenses', expense.toJson());
  }

  // Get all expenses
  Future<List<ExpenseModel>> getAllExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('expenses');

    return List.generate(maps.length, (i) {
      return ExpenseModel.fromJson(maps[i]);
    });
  }

  // Delete expense
  Future<void> deleteExpense(String id) async {
    final db = await database;
    await db.delete('expenses', where: 'id : ?', whereArgs: [id]);
  }

  // Update expense
  Future<void> updateExpense(ExpenseModel expense) async {
    final db = await database;
    await db.update('expenses', expense.toJson(),
        where: 'id : ?', whereArgs: [expense.id]);
  }
}
