// ignore_for_file: use_build_context_synchronously
import 'package:fitness4all/screen/home/Main_home/home_screen.dart';
import 'package:fitness4all/screen/login/login_screen.dart';
import 'package:fitness4all/screen/login/select_age_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  // Function to Register User
  Future<void> signUp() async {
    // Check if fields are empty
    if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
      showError("Email and password cannot be empty");
      return;
    }

    setState(() => isLoading = true);

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Navigate to SelectAgeScreen after signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SelectAgeScreen(userId: userCredential.user!.uid),
        ),
      );
    } on FirebaseAuthException catch (e) {
      showError(e.message ?? "Signup failed");
    } finally {
      setState(() => isLoading = false);
    }
  }

  // Function to Save Age in Firebase Firestore
  Future<void> saveUserAge(int age, String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'age': age,
    }, SetOptions(merge: true));

    // Navigate to Home Screen after saving age
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  // Show Error Message
  void showError(String message) {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign Up for Fitness4All",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: signUp,
                    child: const Text("Create Account"),
                  ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text("Already have an account? Log in"),
            ),
          ],
        ),
      ),
    );
  }
}
