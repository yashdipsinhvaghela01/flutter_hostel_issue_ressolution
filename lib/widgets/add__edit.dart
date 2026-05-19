import 'package:flutter/material.dart';
import 'package:flutter_hostel_issue_resolution/widgets/listing.dart';

class AddComplaintScreen extends StatefulWidget {
  final Complaint? complaint;

  const AddComplaintScreen({super.key, this.complaint});

  @override
  State<AddComplaintScreen> createState() => _AddComplaintScreenState();
}

class _AddComplaintScreenState extends State<AddComplaintScreen> {
  late TextEditingController titleController;

  late TextEditingController descriptionController;

  String selectedStatus = "Pending";

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(
      text: widget.complaint?.title ?? "",
    );

    descriptionController = TextEditingController(
      text: widget.complaint?.description ?? "",
    );

    selectedStatus = widget.complaint?.status ?? "Pending";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.complaint == null ? "Add Complaint" : "Edit Complaint",
        ),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: selectedStatus,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Status",
              ),
              items: const [
                DropdownMenuItem(value: "Pending", child: Text("Pending")),
                DropdownMenuItem(
                  value: "In Progress",
                  child: Text("In Progress"),
                ),
                DropdownMenuItem(value: "Solved", child: Text("Solved")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedStatus = value!;
                });
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    "title": titleController.text,
                    "description": descriptionController.text,
                    "status": selectedStatus,
                  });
                },
                child: Text(
                  widget.complaint == null
                      ? "Add Complaint"
                      : "Update Complaint",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
