import 'package:hive/hive.dart';

part 'employee.g.dart';

@HiveType(typeId: 0)
class EmployeeModel {
  EmployeeModel({
    this.id,
    this.name,
    this.age,
    this.address,
  });

  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? age;

  @HiveField(3)
  String? address;
}
