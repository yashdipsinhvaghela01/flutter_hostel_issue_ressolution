import 'package:flutter/material.dart';
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