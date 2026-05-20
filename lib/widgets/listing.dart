import 'package:flutter/material.dart';
import 'package:flutter_hostel_issue_resolution/widgets/add__edit.dart';  

class HostelApp extends StatelessWidget {
  const HostelApp({super.key, required this.complaintList});
  final List<Complaint> complaintList;

  @override
  Widget build(BuildContext context) {
    return ComplaintScreen(complaintList: complaintList);
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
  final List<Complaint> complaintList;
  const ComplaintScreen({super.key, required this.complaintList});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {

  void deleteComplaint(int index) {
    setState(() {
      widget.complaintList.removeAt(index);
    });
  }

  Color getStatusColor(String status) {
    if (status == "Pending") {
      return Colors.orange;
    } else if (status == "In Progress") {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }

  void navigateToAddEditScreen({Complaint? complaint, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditComplaintScreen(
          complaint: complaint,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        if (complaint == null) {
          widget.complaintList.add(
            Complaint(
              title: result["title"],
              description: result["description"],
              status: result["status"],
            ),
          );
        } else {
         widget.complaintList[index!].title = result["title"];
          widget.complaintList[index].description = result["description"];
          widget.complaintList[index].status = result["status"];
        }
      });
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
        onPressed: () {
          navigateToAddEditScreen(); // Updated call
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: widget.complaintList.length,
        itemBuilder: (context, index) {
          final data = widget.complaintList[index];

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
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      navigateToAddEditScreen( // Updated call
                        complaint: widget.complaintList[index],
                        index: index,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
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