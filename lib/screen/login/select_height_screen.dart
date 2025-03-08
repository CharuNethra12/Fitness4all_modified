// ignore_for_file: use_build_context_synchronously

import 'package:fitness4all/screen/login/select_weight_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 // Import weight selection screen

class SelectHeightScreen extends StatefulWidget {
  final String userId; // Pass user ID
  const SelectHeightScreen({super.key, required this.userId});

  @override
  State<SelectHeightScreen> createState() => _SelectHeightScreenState();
}

class _SelectHeightScreenState extends State<SelectHeightScreen> {
  List valueFtArr = [];
  List valueInchArr = [];

  int selectFt = 5; // Default to 5 feet
  int selectInch = 0;

  @override
  void initState() {
    super.initState();

    for (var i = 2; i < 11; i++) {
      valueFtArr.add({"name": "$i Ft", "value": i});
    }

    for (var i = 0; i < 12; i++) {
      valueInchArr.add({"name": "$i Inch", "value": i});
    }
  }

  // Save Height in Firebase Firestore
  Future<void> saveUserHeight(int ft, int inch) async {
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).set({
      'height': "$ft ft $inch in",
    }, SetOptions(merge: true));

    // Navigate to Weight Selection
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SelectWeightScreen(userId: widget.userId, didChange: () {  },),
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
                "Select Your Height",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 32,
                        onSelectedItemChanged: (value) {
                          setState(() {
                            selectFt = valueFtArr[value]["value"];
                          });
                        },
                        children: List<Widget>.generate(valueFtArr.length, (index) {
                          var obj = valueFtArr[index];
                          return Text("${obj["name"]}");
                        }),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 32,
                        onSelectedItemChanged: (value) {
                          setState(() {
                            selectInch = valueInchArr[value]["value"];
                          });
                        },
                        children: List<Widget>.generate(valueInchArr.length, (index) {
                          var obj = valueInchArr[index];
                          return Text("${obj["name"]}");
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  saveUserHeight(selectFt, selectInch);
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
