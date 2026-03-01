import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StudentFormPage extends StatefulWidget {
  final Map? student;

  const StudentFormPage({super.key, this.student});

  @override
  State<StudentFormPage> createState() => StudentFormPageState();
}

class StudentFormPageState extends State<StudentFormPage> {
  final supabase = Supabase.instance.client;

  final nameController = TextEditingController();
  final nimController = TextEditingController();
  final majorController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.student != null) {
      nameController.text = widget.student!['name'];
      nimController.text = widget.student!['nim'];
      majorController.text = widget.student!['major'];
    }
  }

  Future<void> saveStudent() async {
    if (widget.student == null) {
      // Nanti ngoding disini untuk create
    } else {
      // Nanti ngoding disini untuk update
    }

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null
            ? "Tambah Mahasiswa"
            : "Edit Mahasiswa"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: nimController,
              decoration: InputDecoration(labelText: "NIM"),
            ),
            TextField(
              controller: majorController,
              decoration: InputDecoration(labelText: "Jurusan"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveStudent,
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}