import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "Version 1.0",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 200),
          const Icon(Icons.house, size: 51),
          const Text(" Welcome ", style: TextStyle(fontSize: 30)),
          const SizedBox(height: 150),
          const CircularProgressIndicator(),
          const SizedBox(height: 40),
          const Text(
            "Loading...",
            style: TextStyle(color: Colors.amber, fontSize: 21),
          ),
          const Spacer(),
          const Text(
            "All Rights are Reserved 2025-26",
            style: TextStyle(color: Color.fromARGB(255, 5, 25, 241), fontSize: 17),
          ),
        ],
      ),
    );
  }
}