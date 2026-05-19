import 'package:flutter/material.dart';
import 'package:flutter_hostel_issue_resolution/widgets/add__edit.dart';

class HostelApp extends StatelessWidget {
  const HostelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ComplaintScreen());
  }
}

class Complaint {
  String title;
  String description;
  String status;

  Complaint({
    required this.title,
    required this.description,
    required this.status,
  });
}

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final List<Complaint> complaints = [
    Complaint(
      title: "Light not working",
      description: "Tube light is not working properly",
      status: "Pending",
    ),
    Complaint(
      title: "Water leakage",
      description: "Bathroom tap is leaking",
      status: "In Progress",
    ),
  ];

  
  void addComplaint() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddComplaintScreen()),
    );

    if (result != null) {
      setState(() {
        complaints.add(
          Complaint(
            title: result["title"],
            description: result["description"],
            status: result["status"],
          ),
        );
      });
    }
  }

  void editComplaint(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddComplaintScreen(complaint: complaints[index]),
      ),
    );

    if (result != null) {
      setState(() {
        complaints[index].title = result["title"];
        complaints[index].description = result["description"];
        complaints[index].status = result["status"];
      });
    }
  }

  void deleteComplaint(int index) {
    setState(() {
      complaints.removeAt(index);
    });
  }

  // STATUS COLOR
  Color getStatusColor(String status) {
    if (status == "Pending") {
      return Colors.orange;
    } else if (status == "In Progress") {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hostel Complaints"),
        backgroundColor: Colors.blue,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addComplaint,
        child: const Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          final data = complaints[index];

          return Card(
            color: const Color.fromARGB(255, 194, 105, 134),
            margin: const EdgeInsets.all(10),
            elevation: 10,
            child: ListTile(
              isThreeLine: true,

              title: Text(
                data.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.description),

                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: getStatusColor(data.status),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Status: ${data.status}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.black),
                    onPressed: () {
                      editComplaint(index);
                    },
                  ),

                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      deleteComplaint(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ADD / EDIT SCREEN
