import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness4all/screen/login/select_height_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectAgeScreen extends StatefulWidget {
  final String userId;
  const SelectAgeScreen({super.key, required this.userId});

  @override
  State<SelectAgeScreen> createState() => _SelectAgeScreenState();
}

class _SelectAgeScreenState extends State<SelectAgeScreen> {
  List<Map<String, dynamic>> valueArr = [];
  int selectedAge = 18; // Default age

  @override
  void initState() {
    super.initState();
    for (var i = 1; i < 120; i++) {
      valueArr.add({"name": "$i", "value": i});
    }
  }

  Future<void> saveUserAge(int age) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("Error: No user is logged in.");
      return; // Exit function if no user is logged in
    }

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        {'age': age},
        SetOptions(merge: true),
      );

      // Navigate to Height Selection only after saving age
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SelectHeightScreen(userId: widget.userId),
        ),
      );
    } catch (e) {
      print("Error saving age: $e");
    }
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
                "Select Your Age",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 200,
                child: CupertinoPicker(
                  itemExtent: 32,
                  onSelectedItemChanged: (value) {
                    setState(() {
                      selectedAge = valueArr[value]["value"];
                    });
                  },
                  children: valueArr
                      .map((obj) => Text(obj["name"].toString()))
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  saveUserAge(selectedAge);
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
