import 'package:flutter/material.dart';
import 'package:flutter_hostel_issue_resolution/widgets/listing.dart';
import 'package:flutter_hostel_issue_resolution/widgets/fragment_holder.dart';
import 'widgets/Splash.dart';
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Splash(),
      ),
    ),
  );
}
