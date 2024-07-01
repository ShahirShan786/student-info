import 'package:sqflite/sqflite.dart';
import 'package:student_info/screens/model.dart';

// OPEN DATABASE
late Database _db;

Future<void> initializeDatabase() async {
  _db = await openDatabase(
    'student.db', version: 1,
    //  IF THERE NO DATABASE THEN CREATE
    onCreate: (Database db, version) async {
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY , name TEXT, age INTEGER, rollNumber INTEGER, department TEXT, phoneNumber TEXT ,imageUrl)');
    },
  );
}


// FOR ADD STUDENT-DETAILES TO DATABASE

Future<void>addStudent(StudentModel value)async {
  await _db.rawInsert(
  'INSERT INTO student(id,name ,age,rollNumber,department,phoneNumber,imageUrl) VALUES(?, ?, ?, ?, ?, ?, ?)',
[
  value.id,
  value.name,
  value.age,
  value.rollNumer,
  value.department,
  value.phoneNumber,
  value.imageUrl
],


  );
  print("Data added");
  getAllStudent();
}

//FOR GET ALL STUDENT-DATA

Future<List<Map<String, dynamic>>> getAllStudent() async {
  final values = await _db.rawQuery('SELECT * FROM student');
  return values;

  
}

// for update student detailes

Future<void>updateStudentData(StudentModel updateStudent)async{

  await _db.update('student',
   {
      'name' : updateStudent.name,
      'age' : updateStudent.age,
      'rollNumber' : updateStudent.rollNumer,
      'department' : updateStudent.department,
      'phoneNumber' : updateStudent.phoneNumber
  },
  where: 'id = ?',
  whereArgs: [updateStudent.id],
  
  );
}

// for delete student data

Future<void> deleteStudent(int id)async {
  await _db.rawDelete(
    'DELETE FROM student WHERE id = ?', [id]
  );
}