import 'package:flutter/material.dart';

void main() {
  runApp(const StudentRecordApp());
}

class StudentRecordApp extends StatelessWidget {
  const StudentRecordApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Record Management',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const StudentHomePage(),
    );
  }
}

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rollController = TextEditingController();
  final TextEditingController deptController = TextEditingController();

  List<Map<String, String>> students = [];

  void addStudent() {
    if (nameController.text.isNotEmpty &&
        rollController.text.isNotEmpty &&
        deptController.text.isNotEmpty) {
      setState(() {
        students.add({
          'name': nameController.text,
          'roll': rollController.text,
          'dept': deptController.text,
        });
      });

      
      nameController.clear();
      rollController.clear();
      deptController.clear();
    }
  }

  void cancelInput() {
    nameController.clear();
    rollController.clear();
    deptController.clear();
  }

  void deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Record Management'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Student Name
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Student Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            
            TextField(
              controller: rollController,
              decoration: const InputDecoration(
                labelText: 'Roll Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            
            TextField(
              controller: deptController,
              decoration: const InputDecoration(
                labelText: 'Department',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: addStudent,
                    child: const Text('Add Student'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: cancelInput,
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'Student List',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            
            Expanded(
              child: students.isEmpty
                  ? const Center(child: Text('No Records Found'))
                  : ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(students[index]['name']!),
                            subtitle: Text(
                              'Roll: ${students[index]['roll']} | Dept: ${students[index]['dept']}',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteStudent(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
