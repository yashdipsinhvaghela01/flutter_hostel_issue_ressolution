import 'package:flutter/material.dart';
import 'package:flutter_hostel_issue_resolution/widgets/listing.dart';
import 'widgets/Splash.dart';
import 'widgets/fragment_holder.dart';
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body:FragmentHolder(),
        body: HostelApp() ,
      ),
    ),
  );
}
