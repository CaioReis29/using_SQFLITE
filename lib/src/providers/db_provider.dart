import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_database/src/data/models/employee_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    // caso já exista o banco de dados, vai retorná-lo
    if (_database != null) return _database;

    // se o banco de dados não existir, vai criar um através da função
    _database = await initDB();

    return _database;
  }

  // cria o banco de dados e a tabela employee(funcionários)
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'employee_manager.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE Employee('
            'id INTEGER PRIMARY KEY,'
            'email TEXT,'
            'firstName TEXT,'
            'lastNAME TEXT,'
            'avatar TEXT'
            ')');
      },
    );
  }

  // adiciona um funcionário no BD
  createEmployee(EmployeeModel newEmployee) async {
    final db = await database;
    final res = await db!.insert('Employee', newEmployee.toJson());

    return res;
  }

  // deleta todos os funcionários do BD
  Future<int> deleteAllEmployees() async {
    final db = await database;
    final res = await db!.rawDelete('DELETE FROM Employee');
    return res;
  }

  Future<List<EmployeeModel>> getAllEmployees() async {
    final db = await database;
    final res = await db!.rawQuery('SELECT * FROM EMPLOYEE');

    List<EmployeeModel> list = res.isNotEmpty
        ? res.map((e) => EmployeeModel.fromJson(e)).toList()
        : [];

    return list;
  }
}
