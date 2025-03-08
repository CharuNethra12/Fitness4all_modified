import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'physique_screen.dart';

class GoalScreen extends StatefulWidget {
  final String userId;
  const GoalScreen({super.key, required this.userId});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  String selectedGoal = "Fat Loss"; // Default selection

  // Save Goal in Firestore
  Future<void> saveUserGoal(String goal) async {
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).set({
      'fitness_goal': goal,
    }, SetOptions(merge: true));

    // Navigate to PhysiqueScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PhysiqueScreen(userId: widget.userId),
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
                "Select Your Goal",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              RadioListTile(
                title: const Text("Fat Loss"),
                value: "Fat Loss",
                groupValue: selectedGoal,
                onChanged: (value) {
                  setState(() {
                    selectedGoal = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: const Text("Weight Gain"),
                value: "Weight Gain",
                groupValue: selectedGoal,
                onChanged: (value) {
                  setState(() {
                    selectedGoal = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: const Text("Muscle Gain"),
                value: "Muscle Gain",
                groupValue: selectedGoal,
                onChanged: (value) {
                  setState(() {
                    selectedGoal = value.toString();
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  saveUserGoal(selectedGoal);
                },
                child: const Text("Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
