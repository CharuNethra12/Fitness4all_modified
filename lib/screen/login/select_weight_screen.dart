import 'package:fitness4all/screen/login/select_level_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import fitness level selection screen

class SelectWeightScreen extends StatefulWidget {
  final String userId; // Pass user ID
  const SelectWeightScreen({super.key, required this.userId, required Null Function() didChange});

  @override
  State<SelectWeightScreen> createState() => _SelectWeightScreenState();
}

class _SelectWeightScreenState extends State<SelectWeightScreen> {
  List valueArr = [];
  int selectedWeight = 60; // Default weight

  @override
  void initState() {
    super.initState();
    for (var i = 30; i < 200; i++) {
      valueArr.add({"name": "$i kg", "value": i});
    }
  }

  // Save Weight in Firebase Firestore
  Future<void> saveUserWeight(int weight) async {
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).set({
      'weight': "$weight kg",
    }, SetOptions(merge: true));

    // Navigate to Fitness Level Selection
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SelectLevelScreen(userId: widget.userId),
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
                "Select Your Weight",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 200,
                child: CupertinoPicker(
                  itemExtent: 32,
                  onSelectedItemChanged: (value) {
                    setState(() {
                      selectedWeight = valueArr[value]["value"];
                    });
                  },
                  children: List<Widget>.generate(valueArr.length, (index) {
                    var obj = valueArr[index];
                    return Text("${obj["name"]}");
                  }),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  saveUserWeight(selectedWeight);
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
