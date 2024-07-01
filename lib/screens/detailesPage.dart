import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_info/constant.dart';

class DetailesPage extends StatelessWidget {
  final Map<String, dynamic> student;
  const DetailesPage({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: prymaryColor,
        foregroundColor: Colors.white,
        title: Text("Details of Student"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 23, top: 50),
        child: Container(
          width: 350,
          height: 550,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 195, 195, 195),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              CircleAvatar(
                backgroundColor: Colors.green,
                backgroundImage: FileImage(File(student['imageUrl'])),
                radius: 80,
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      student['name'],
                      style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w600,
                          fontFamily: "PoetsenOne"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Department : ${student['department']}",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Roboto-font"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Roll No : ${student['rollNumber']}",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Roboto-font"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Mobile Number : ${student['phoneNumber']}",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Roboto-font"),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
