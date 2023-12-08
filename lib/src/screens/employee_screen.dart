import 'package:flutter/material.dart';
import 'package:sqflite_database/src/providers/Employee_api_provider.dart';
import 'package:sqflite_database/src/providers/db_provider.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 144, 209, 240),
        elevation: 6,
        centerTitle: true,
        title: const Text('Using SQFLITE'),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async => await _loadFromApi(),
              icon: const Icon(Icons.settings_input_antenna),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async => await _deleteData(),
              icon: const Icon(Icons.delete),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : buildEmployeeListView(),
    );
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = EmployeeApiProvider();
    await apiProvider.getAllEmployees();

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteAllEmployees();

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });
  }

  Widget buildEmployeeListView() => FutureBuilder(
        future: DBProvider.db.getAllEmployees(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) => ListTile(
                leading: Text(
                  "${index + 1}",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                title: Text(
                    "Name: ${snapshot.data![index].firstName} ${snapshot.data![index].lastName}}"),
                subtitle: Text("E-mail: ${snapshot.data![index].email}}"),
              ),
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
              ),
              itemCount: snapshot.data!.length,
            );
          }
        },
      );
}
