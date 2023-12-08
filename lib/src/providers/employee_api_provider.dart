// ignore_for_file: file_names

import 'dart:developer';

import 'package:sqflite_database/src/data/models/employee_model.dart';
import 'package:dio/dio.dart';
import 'package:sqflite_database/src/providers/db_provider.dart';

class EmployeeApiProvider {
  Future<List<EmployeeModel>> getAllEmployees() async {
    var url = "http://demo8161595.mockable.io/employee";
    Response response = await Dio().get(url);

    return (response.data).map((employee) {
      log('Inserting $employee');
      return DBProvider.db.createEmployee(EmployeeModel.fromJson(employee));
    }).toList();
  }
}
