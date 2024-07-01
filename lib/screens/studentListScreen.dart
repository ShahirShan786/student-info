// ignore_for_file: unnecessary_import, duplicate_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_info/constant.dart';
import 'package:student_info/constant.dart';
import 'package:student_info/constant.dart';
import 'package:student_info/function/functions.dart';
import 'package:student_info/screens/addStudentScreen.dart';
import 'package:student_info/screens/detailesPage.dart';
import 'package:student_info/screens/model.dart';

class StudentListscreen extends StatefulWidget {
  const StudentListscreen({super.key});

  @override
  State<StudentListscreen> createState() => _StudentListscreenState();
}

class _StudentListscreenState extends State<StudentListscreen> {
  late List<Map<String, dynamic>> _studentdata = [];
  final TextEditingController _searchController = TextEditingController();
  final editFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    allStudentData();

    super.initState();
  }

  Future<void> allStudentData() async {
    List<Map<String, dynamic>> students = await getAllStudent();

    students = students
        .where((students) => students['name']
            .toString()
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
        .toList();

    setState(() {
      _studentdata = students;
    });
  }

  Future<void> showEditDialoguebox(int index) async {
    final student = _studentdata[index];

    final TextEditingController nameController =
        TextEditingController(text: student['name'].toString());
    final TextEditingController ageController =
        TextEditingController(text: student['age'].toString());
    final TextEditingController rollnumberController =
        TextEditingController(text: student['rollNumber'].toString());
    final TextEditingController departmentController =
        TextEditingController(text: student['department'].toString());
    final TextEditingController phoneNumberConroller =
        TextEditingController(text: student['phoneNumber'].toString());

    showDialog(
        context: context,
        builder: (BuildContext) => AlertDialog(
              title: const Text("Edit Student"),
              content: SingleChildScrollView(
                child: Form(
                  key: editFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(label: Text("Name")),
                        validator: (value) => value == null || value.isEmpty
                            ? "name is required"
                            : null,
                      ),
                      TextFormField(
                        controller: ageController,
                        decoration: const InputDecoration(label: Text("Age")),
                        validator: (value) => value == null || value.isEmpty
                            ? "Age is required"
                            : null,
                      ),
                      TextFormField(
                        controller: rollnumberController,
                        decoration:
                            const InputDecoration(label: Text("Roll number")),
                        validator: (value) => value == null || value.isEmpty
                            ? "Roll number is required"
                            : null,
                      ),
                      TextFormField(
                        controller: departmentController,
                        decoration:
                            const InputDecoration(label: Text("Department")),
                        validator: (value) => value == null || value.isEmpty
                            ? "department is required"
                            : null,
                      ),
                      TextFormField(
                        controller: phoneNumberConroller,
                        decoration:
                            const InputDecoration(label: Text("Phone number")),
                        validator: (value) => value == null || value.isEmpty
                            ? "Phone is required"
                            : null,
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel")),
                TextButton(
                  onPressed: () async {
                    if (editFormKey.currentState!.validate()) {
                      await updateStudentData(StudentModel(
                          id: student['id'],
                          name: nameController.text,
                          age: ageController.text,
                          rollNumer: rollnumberController.text,
                          department: departmentController.text,
                          phoneNumber: phoneNumberConroller.text,
                          imageUrl: student['imageUrl']));
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                      allStudentData(); // for Refresh the list
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            "Chages Updated",
                            style: TextStyle(color: Colors.white),
                          )));
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: prymaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          "Student List",
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              fontFamily: "Roboto-font"),
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      allStudentData();
                    });
                  },
                  decoration: const InputDecoration(
                    label: Text("Search"),
                    labelStyle: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
      body: _studentdata.isEmpty
          ? const Center(
              child: Text("No students available."),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                final student = _studentdata[index];
                final studentId = student['id'];
                final studentImage = student['imageUrl'];
                return Card(
                  color: Colors.grey[100],
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => DetailesPage(
                                student: student,
                              )));
                    },
                    leading: GestureDetector(
                      onTap: () {
                        if (studentImage != null) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.file(
                                          File(studentImage),
                                        ),
                                      ],
                                    ),
                                  ));
                        }
                      },
                      child: CircleAvatar(
                          radius: 30,
                          backgroundImage: studentImage != null
                              ? FileImage(File(studentImage))
                              : null,
                          child: studentImage == null
                              ? const Icon(Icons.person)
                              : null),
                    ),
                    title: Text(student['name']),
                    subtitle: Text(student['department']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showEditDialoguebox(index);
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext) => AlertDialog(
                                        title: const Text("Delete Student"),
                                        content: const Text(
                                            "Are you sure want to delete"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Cancel")),
                                          TextButton(
                                              onPressed: () async {
                                                await deleteStudent(studentId);
                                                allStudentData();
                                                // ignore: use_build_context_synchronously
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  backgroundColor: Colors.black,
                                                  content: Text(
                                                    "Deleted Succesfully",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ));
                                                // ignore: use_build_context_synchronously
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Ok"))
                                        ],
                                      ));
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[400],
                            ))
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: _studentdata.length),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const AddStudentScreen()));
        },
        child: Icon(Icons.add),
        backgroundColor: prymaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
