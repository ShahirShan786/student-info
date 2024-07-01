// import 'dart:html';
// import 'dart:io';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_info/constant.dart';

import 'package:image_picker/image_picker.dart';
import 'package:student_info/function/functions.dart';
import 'package:student_info/screens/model.dart';
import 'package:student_info/screens/studentListScreen.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _rollnumberController = TextEditingController();
  final _departmentController = TextEditingController();
  final _phoneController = TextEditingController();

  File? pickedImage;
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: prymaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          "Student Information",
          style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              fontFamily: "Roboto-font"),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(userAvatar),
                    child: GestureDetector(
                        onTap: () async {
                          // ignore: no_leading_underscores_for_local_identifiers
                          File? _pickimage = await getImage();
                          setState(() {
                            _selectedImage = _pickimage;
                          });
                        },
                        child: _selectedImage != null
                            ? ClipOval(
                                child: Image.file(
                                  _selectedImage!,
                                  height: 160,
                                  width: 160,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : null),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        label: Text("Student Name"),
                        prefixIcon: Icon(Icons.account_circle_rounded),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name is Required";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("Age"),
                        prefixIcon: Icon(Icons.person),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Age is required";
                        } else {
                          int? age = int.tryParse(value);
                          if (age == null) {
                            return "Please enter a Valid age";
                          } else if (age <= 0) {
                            return "Age must be greater than zero";
                          } else if (age > 120) {
                            return "Age must be less than 120";
                          } else {
                            return null;
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      controller: _rollnumberController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: false),
                      decoration: const InputDecoration(
                        label: Text("Roll Number"),
                        prefixIcon: Icon(Icons.info),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "Roll numebr is Required"
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      controller: _departmentController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        label: Text("Department"),
                        prefixIcon: Icon(Icons.school),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "Department is Required"
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      controller: _phoneController,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        label: Text("Phone"),
                        prefixIcon: Icon(Icons.phone),
                        prefix: Text(
                          "+91  ",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone number is required';
                        }
                        if (value.length != 10) {
                          return "Please enter a valid Phone number";
                        }
                        // Add further validation if needed
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_selectedImage == null) {
                              const imageErrorMessage =
                                  "You must select a profile Picture";
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    imageErrorMessage,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                              return;
                            }
                            final student = StudentModel(
                                name: _nameController.text,
                                age: _ageController.text,
                                rollNumer: _rollnumberController.text,
                                department: _departmentController.text,
                                phoneNumber: _phoneController.text,
                                // ignore: prefer_null_aware_operators
                                imageUrl: _selectedImage != null
                                    ? _selectedImage!.path
                                    : null);

                            await addStudent(student);
                            const successfulMessage = "Data added Successfully";
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  successfulMessage,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                            _nameController.clear();
                            _ageController.clear();
                            _rollnumberController.clear();
                            _departmentController.clear();
                            _phoneController.clear();
                            setState(() {
                              _selectedImage = null;
                            });

                            getAllStudent();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const StudentListscreen(),
                                ),
                                (Route<dynamic> route) => false);
                          }
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(fontSize: 15, color: prymaryColor),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _nameController.clear();
                          _ageController.clear();
                          _rollnumberController.clear();
                          _departmentController.clear();
                          _phoneController.clear();
                          setState(() {
                            _selectedImage = null;
                          });
                        },
                        child: const Text(
                          "Clear",
                          style: TextStyle(fontSize: 15, color: prymaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // For selection of avatar

  Future<File?> getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      return File(pickedImage.path);
    } else {
      return null;
    }
  }
}
