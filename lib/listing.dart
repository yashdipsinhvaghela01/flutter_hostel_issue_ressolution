import 'package:flutter/material.dart';

void main() {
  runApp(const HostelApp());
}

class HostelApp extends StatelessWidget {
  const HostelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ComplaintScreen(),
    );
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

  // ADD COMPLAINT
  void addComplaint() {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController =
        TextEditingController();

    String selectedStatus = "Pending";

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Add Complaint"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Title",
                      ),
                    ),

                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: "Description",
                      ),
                    ),

                    const SizedBox(height: 10),

                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      decoration: const InputDecoration(
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
                        setDialogState(() {
                          selectedStatus = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      complaints.add(
                        Complaint(
                          title: titleController.text,
                          description: descriptionController.text,
                          status: selectedStatus,
                        ),
                      );
                    });

                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void editComplaint(int index) {
    TextEditingController titleController =
        TextEditingController(text: complaints[index].title,);

    TextEditingController descriptionController =
        TextEditingController(
      text: complaints[index].description,
    );

    String selectedStatus = complaints[index].status;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Edit Complaint"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Title",
                      ),
                    ),

                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: "Description",
                      ),
                    ),

                    const SizedBox(height: 10),

                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
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
                        setDialogState(() {
                          selectedStatus = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      complaints[index].title =
                          titleController.text;

                      complaints[index].description =
                          descriptionController.text;

                      complaints[index].status =
                          selectedStatus;
                    });

                    Navigator.pop(context);
                  },
                  child: const Text("Update"),
                ),
              ],
            );
          },
        );
      },
    );
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
                crossAxisAlignment:
                    CrossAxisAlignment.start,
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
                      borderRadius:
                          BorderRadius.circular(20),
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
                    icon: const Icon(
                      Icons.edit,
                      color: Color.fromARGB(
                          255, 56, 55, 54),
                    ),
                    onPressed: () {
                      editComplaint(index);
                    },
                  ),

                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Color.fromARGB(
                          255, 48, 47, 47),
                    ),
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