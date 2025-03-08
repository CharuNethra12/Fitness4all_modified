import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'goal_screen.dart'; // Import goal selection screen

class SelectLevelScreen extends StatefulWidget {
  final String userId; // Pass user ID
  const SelectLevelScreen({super.key, required this.userId});

  @override
  State<SelectLevelScreen> createState() => _SelectLevelScreenState();
}

class _SelectLevelScreenState extends State<SelectLevelScreen> {
  int selectType = 0;
  String selectedLevel = "Beginner"; // Default selection

  // Save Fitness Level in Firebase Firestore
  Future<void> saveUserLevel(String level) async {
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).set({
      'fitness_level': level,
    }, SetOptions(merge: true));

    // Navigate to Goal Selection
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GoalScreen(userId: widget.userId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Select Your Fitness Level",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              RadioListTile(
                title: const Text("Beginner"),
                value: "Beginner",
                groupValue: selectedLevel,
                onChanged: (value) {
                  setState(() {
                    selectedLevel = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: const Text("Intermediate"),
                value: "Intermediate",
                groupValue: selectedLevel,
                onChanged: (value) {
                  setState(() {
                    selectedLevel = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: const Text("Advanced"),
                value: "Advanced",
                groupValue: selectedLevel,
                onChanged: (value) {
                  setState(() {
                    selectedLevel = value.toString();
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  saveUserLevel(selectedLevel);
                },
                child: const Text("Confirm"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
