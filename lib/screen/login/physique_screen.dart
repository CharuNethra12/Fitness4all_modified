import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness4all/screen/home/Main_home/home_screen.dart';

class PhysiqueScreen extends StatefulWidget {
  final String userId;
  const PhysiqueScreen({super.key, required this.userId});

  @override
  State<PhysiqueScreen> createState() => _PhysiqueScreenState();
}

class _PhysiqueScreenState extends State<PhysiqueScreen> {
  String selectAge = "19";
  String selectHeight = "6 Ft 4 Inch";
  String selectWeight = "78 KG";
  String selectLevel = "Beginner";

  // Save Physique Data in Firestore
  Future<void> savePhysiqueData() async {
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).set({
      'age': selectAge,
      'height': selectHeight,
      'weight': selectWeight,
      'fitness_level': selectLevel,
    }, SetOptions(merge: true));

    // Navigate to HomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Enter Your Physique",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),
              ListTile(
                title: const Text("Age"),
                subtitle: Text("$selectAge Yrs"),
                onTap: () {
                  // Show age selection modal
                },
              ),
              ListTile(
                title: const Text("Height"),
                subtitle: Text(selectHeight),
                onTap: () {
                  // Show height selection modal
                },
              ),
              ListTile(
                title: const Text("Weight"),
                subtitle: Text(selectWeight),
                onTap: () {
                  // Show weight selection modal
                },
              ),
              ListTile(
                title: const Text("Fitness Level"),
                subtitle: Text(selectLevel),
                onTap: () {
                  // Show fitness level selection modal
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: savePhysiqueData,
                child: const Text("Confirm & Proceed"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
