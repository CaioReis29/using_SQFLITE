import 'dart:convert';

List<EmployeeModel> employeeFromJson(String str) => List<EmployeeModel>.from(
      json.decode(str).map(
            (x) => EmployeeModel.fromJson(x),
          ),
    );
String employeeToJson(List<EmployeeModel> data) => json.encode(
      List<dynamic>.from(
        data.map(
          (e) => e.toJson(),
        ),
      ),
    );

class EmployeeModel {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  EmployeeModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        id: json["id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "avatar": avatar,
      };
}
