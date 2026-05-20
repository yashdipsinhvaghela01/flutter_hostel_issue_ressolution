import 'package:flutter/material.dart';
import 'package:flutter_hostel_issue_resolution/widgets/listing.dart';

class AddEditComplaintScreen extends StatefulWidget {
  final Complaint? complaint;

  const AddEditComplaintScreen({
    super.key,
    this.complaint,
  });

  @override
  State<AddEditComplaintScreen> createState() =>
      _AddEditComplaintScreenState();
}

class _AddEditComplaintScreenState extends State<AddEditComplaintScreen> {
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
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                maxLines: 5, 
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
                  DropdownMenuItem(
                    value: "Pending",
                    child: Text("Pending"),
                  ),
                  DropdownMenuItem(
                    value: "In Progress",
                    child: Text("In Progress"),
                  ),
                  DropdownMenuItem(
                    value: "Solved",
                    child: Text("Solved"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
                },
              ),
              const SizedBox(height: 30),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                  
                        Navigator.pop(context, {
                          "title": titleController.text,
                          "description": descriptionController.text,
                          "status": selectedStatus,
                        });
                      },
                      child: Text(
                        widget.complaint == null ? "Add" : "Update",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}