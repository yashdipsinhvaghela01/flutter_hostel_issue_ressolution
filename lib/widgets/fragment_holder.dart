import 'package:flutter/material.dart';
import 'package:flutter_hostel_issue_resolution/widgets/add__edit.dart';
import 'package:flutter_hostel_issue_resolution/widgets/listing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
              builder: (context) => HomePage(complaintList: complaintList),
            );

          case '/listing':
            return MaterialPageRoute(
              builder: (context) => HostelApp(complaintList: complaintList),
            );

          case '/add_edit':
            return MaterialPageRoute(
              builder: (context) => const AddEditComplaintScreen(),
            );

          default:
            return MaterialPageRoute(
              builder: (context) =>
                  const Scaffold(body: Center(child: Text("Route Not Found"))),
            );
        }
      },
    );
  }
}

class HomePage extends StatefulWidget {
  final List<Complaint> complaintList;

  const HomePage({super.key, required this.complaintList});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadComplaintsFromPrefs();
  }

  Future<void> saveComplaintsToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String jsonString = jsonEncode(
      widget.complaintList.map((c) => c.toJson()).toList(),
    );

    await prefs.setString('complaints', jsonString);
  }

  Future<void> loadComplaintsFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? jsonString = prefs.getString('complaints');

    if (jsonString != null) {
      List decodedList = jsonDecode(jsonString);

      setState(() {
        widget.complaintList.clear();

        widget.complaintList.addAll(
          decodedList.map(
            (item) => Complaint(
              title: item['title'],
              description: item['description'],
              status: item['status'],
            ),
          ),
        );
      });
    }
  }

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
                Navigator.pushNamed(context, '/listing');
              },
              child: const Text("Complaint List"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.pushNamed(context, '/add_edit');

                if (result != null && result is Map) {
                  setState(() {
                    widget.complaintList.add(
                      Complaint(
                        title: result['title'],
                        description: result['description'],
                        status: result['status'],
                      ),
                    );
                  });

                  await saveComplaintsToPrefs();
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
