
class StudentModel {
  int? id;
  final String? name;
  final dynamic age;
  final dynamic rollNumer;
  final String? department;
  final String? phoneNumber;
  final String? imageUrl;

  StudentModel({
     this.id,
    required this.name,
    required this.age,
    required this.rollNumer,
    required this.department,
    required this.phoneNumber,
    required this.imageUrl,
  });
}