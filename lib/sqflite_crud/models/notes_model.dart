// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotesModel {
  int? id;
  String? name;
  int? age;
  String? address;
  NotesModel({
    this.id,
    required this.name,
    required this.age,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'address': address,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      age: map['age'] != null ? map['age'] as int : null,
      address: map['address'] != null ? map['address'] as String : null,
    );
  }
}
