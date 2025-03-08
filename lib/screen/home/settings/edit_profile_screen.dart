import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  String photoURL = "assets/img/default_profile.png";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      nameController.text = user!.displayName ?? "";
      emailController.text = user!.email ?? "";
      photoURL = user!.photoURL ?? "assets/img/default_profile.png";
    }
  }

  Future<void> updateProfile() async {
    setState(() => isLoading = true);
    try {
      await user?.updateDisplayName(nameController.text);
      await user?.updateEmail(emailController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
    setState(() => isLoading = false);
  }

  Future<void> uploadProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    File file = File(image.path);
    setState(() => isLoading = true);
    try {
      final storageRef = FirebaseStorage.instance.ref().child("profile_pics/${user?.uid}.jpg");
      await storageRef.putFile(file);
      String downloadURL = await storageRef.getDownloadURL();

      await user?.updatePhotoURL(downloadURL);
      setState(() {
        photoURL = downloadURL;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile picture updated!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: uploadProfilePicture,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: photoURL.startsWith("http")
                    ? NetworkImage(photoURL)
                    : AssetImage(photoURL) as ImageProvider,
                child: const Icon(Icons.camera_alt, size: 30, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateProfile,
              child: isLoading ? const CircularProgressIndicator() : const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
