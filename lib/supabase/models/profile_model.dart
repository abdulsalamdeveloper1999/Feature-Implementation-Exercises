// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProfileModel {
  final String employeeName;
  final String employeeEmail;
  final int? id;
  ProfileModel({
    this.id,
    required this.employeeName,
    required this.employeeEmail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'employeeName': employeeName,
      'employeeEmail': employeeEmail,
      'id': id,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      employeeName: map['employeeName'] as String,
      employeeEmail: map['employeeEmail'] as String,
      id: map['id'] as int,
    );
  }
}
