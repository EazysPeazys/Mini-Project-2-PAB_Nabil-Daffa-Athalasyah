import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'student_form_page.dart';

class StudentPage extends StatefulWidget {

  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final supabase = Supabase.instance.client;

  List students = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    // Nanti kode read data disini
  }

  Future<void> deleteStudent(int id) async {
    // Nanti kode delete data disini
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Data Mahasiswa")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.to(StudentFormPage());
          fetchStudents();
        },
        child: Icon(Icons.add),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : students.isEmpty
              ? Center(child: Text("Data masih kosong"))
              : ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];

                    return ListTile(
                      title: Text(student['name']),
                      subtitle: Text(student['nim']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              await Get.to(
                                StudentFormPage(student: student),
                              );
                              fetchStudents();
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () =>
                                deleteStudent(student['id']),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}