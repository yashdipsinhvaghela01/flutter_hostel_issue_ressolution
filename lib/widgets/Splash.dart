import 'package:flutter/material.dart';

class Splash extends StatefulWidget{
const Splash({super.key});

@override
  State<Splash> createState() => _Splashstate();
}

class _Splashstate extends State<Splash>{

  @override
  Widget build(BuildContext context){
  return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent,
            Colors.purpleAccent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "1.0",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),

                    const Icon(
                      Icons.house_outlined,
                      size: 80,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Welcome",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),

                    const SizedBox(height: 60),
                    const Icon(
                      Icons.loop_rounded,
                      size: 44,
                      color: Colors.white70,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Loading...",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 300,),
                    Text("All Rights are Reserved 2025-26",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 15,
                    ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}