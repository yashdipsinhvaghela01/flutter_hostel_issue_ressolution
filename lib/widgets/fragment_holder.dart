import 'package:flutter/material.dart';
import 'package:flutter_hostel_issue_resolution/widgets/add__edit.dart';
import 'package:flutter_hostel_issue_resolution/widgets/listing.dart';

class FragmentHolder extends StatelessWidget {
  const FragmentHolder({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Complaint> complaintList = [
       Complaint(
      title: "Light not working",
      description: "Tube light in room 101 is not working properly",
      status: "Pending",
    ),
    Complaint(
      title: "Water leakage",
      description: "Bathroom tap in room 203 is leaking",
      status: "In Progress",
    ),
    Complaint(
      title: "Broken window",
      description: "Window glass in room 305 is cracked",
      status: "Pending",
    ),
    Complaint(
      title: "No hot water",
      description: "Geyser in block B is not heating water",
      status: "Solved",
    ),
    Complaint(
      title: "Noisy fan",
      description: "Ceiling fan in room 112 makes loud noise",
      status: "In Progress",
    ),
    ];

    return MaterialApp(
    debugShowCheckedModeBanner: false,
      initialRoute: '/',

      onGenerateRoute: (settings) {

        switch (settings.name) {

          case '/':
            return MaterialPageRoute(
              builder: (context) => HomePage(
                complaintList: complaintList,
              ),
            );

          case '/listing':
            return MaterialPageRoute(
              builder: (context) => HostelApp(
                complaintList: complaintList,
              ),
            );

          case '/add_edit':
            return MaterialPageRoute(
              builder: (context) => const AddEditComplaintScreen(),
            );

          default:
            return MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(
                  child: Text("Route Not Found"),
                ),
              ),
            );
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {

  final List<Complaint> complaintList;

  const HomePage({
    super.key,
    required this.complaintList,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        backgroundColor: Colors.blue,
      ),

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => HostelApp(
                      complaintList: complaintList,
                    ),
                  ),
                );
              },

              child: const Text("commplain List"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddEditComplaintScreen(),
                  ),
                );
                if (result != null) {
                  complaintList.add(
                    Complaint(
                      title: result['title'],
                      description: result['description'],
                      status: result['status'],
                    ),
                  );
                }
                
              },

              child: const Text("Add/Edit complaint"),
            ),
          ],
        ),
      ),
    );
  }
}