// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness4all/screen/home/settings/settings_screen.dart';
import 'package:fitness4all/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:fitness4all/common/color_extensions.dart';
import 'package:fitness4all/screen/home/settings/setting_row.dart';
import 'package:fitness4all/screen/home/settings/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  String displayName = "User Name";
  String email = "example@gmail.com";
  String photoURL = "assets/img/default_profile.png";

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  void fetchUserDetails() {
    if (user != null) {
      setState(() {
        displayName = user!.displayName ?? "User Name";
        email = user!.email ?? "example@gmail.com";
        photoURL = user!.photoURL?.isNotEmpty == true ? user!.photoURL! : "assets/img/default_profile.png";
      });
    }
  }

  Future<void> uploadProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    File file = File(image.path);
    try {
      final storageRef = FirebaseStorage.instance.ref().child("profile_pics/${user?.uid}.jpg");
      await storageRef.putFile(file);
      String downloadURL = await storageRef.getDownloadURL();

      await user?.updatePhotoURL(downloadURL);
      fetchUserDetails(); // Update UI with new image
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: photoURL.startsWith("http")
                      ? Image.network(photoURL, width: 100, height: 100, fit: BoxFit.cover)
                      : Image.asset(
                          photoURL,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Image.asset(
                            "assets/img/default_profile.png",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: uploadProfilePicture,
                        child: const Text("Upload Profile Picture"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(), // Adds separation
          SettingRow(
            title: "Dark Mode",
            icon: "assets/img/dark_mode.png",
            value: "",
            trailingWidget: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
          SettingRow(
            title: "Logout",
            icon: "assets/img/logout.png",
            value: "",
            onPressed: logout,
          ),
        ],
      ),
    );
  }
}
