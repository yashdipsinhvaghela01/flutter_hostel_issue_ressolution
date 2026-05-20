import 'package:flutter/material.dart';
// Make sure this path exactly matches your file structure!
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
  // Track active filter. Default is "All"
  String currentFilter = "All";

  void deleteComplaint(Complaint complaint) {
    setState(() {
      widget.complaintList.remove(complaint);
    });
  }

  // Fallback styling helper with normalized string checks
  Color getStatusColor(String status) {
    final normalized = status.trim().toLowerCase();
    if (normalized == "pending") {
      return Colors.orange;
    } else if (normalized == "in progress") {
      return Colors.blue;
    } else {
      return Colors.green; // Default fallback for 'Solved' or completed
    }
  }

  void navigateToAddEditScreen({Complaint? complaint}) async {
    // Await the map data returning from your form screen
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditComplaintScreen(
          complaint: complaint,
        ),
      ),
    );

    // Safeguard check to ensure data actually came back
    if (result != null && result is Map) {
      setState(() {
        if (complaint == null) {
          // Creating a new complaint safely extracting map string values
          widget.complaintList.add(
            Complaint(
              title: result["title"] ?? "No Title",
              description: result["description"] ?? "",
              status: result["status"] ?? "Pending",
            ),
          );
        } else {
          // Modifying existing complaint object values directly
          complaint.title = result["title"] ?? complaint.title;
          complaint.description = result["description"] ?? complaint.description;
          complaint.status = result["status"] ?? complaint.status;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Normalizing strings ensures filters work even if case sizes vary (e.g. "Pending" vs "pending")
    final filteredList = widget.complaintList.where((complaint) {
      if (currentFilter == "All") return true;
      return complaint.status.trim().toLowerCase() == currentFilter.trim().toLowerCase();
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hostel Complaints"),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToAddEditScreen(),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Filter Chips Horizontal Bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            color: Colors.grey[100],
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ["All", "Pending", "In Progress", "Solved"].map((filterOpt) {
                  final isSelected = currentFilter == filterOpt;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ChoiceChip(
                      label: Text(filterOpt),
                      selected: isSelected,
                      selectedColor: Colors.blue.withOpacity(0.25),
                      checkmarkColor: Colors.blue,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.blue[800] : Colors.black87,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          currentFilter = filterOpt;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          
          // Render the List dynamically
          Expanded(
            child: filteredList.isEmpty
                ? const Center(
                    child: Text(
                      "No complaints here!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final data = filteredList[index];

                      return Card(
                        color: const Color.fromARGB(255, 194, 105, 134),
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        elevation: 4,
                        child: ListTile(
                          isThreeLine: true,
                          title: Text(
                            data.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                data.description,
                                style: const TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: getStatusColor(data.status),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  data.status,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.white),
                                onPressed: () => navigateToAddEditScreen(complaint: data),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.white70),
                                onPressed: () => deleteComplaint(data),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}