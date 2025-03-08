import 'package:fitness4all/screen/home/settings/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness4all/common/color_extensions.dart';
import 'package:fitness4all/screen/home/Meals/meals_screen.dart';
import 'package:fitness4all/screen/home/notification/notification_screen.dart';
import 'package:fitness4all/screen/home/reminder/reminder_screen.dart';
import 'package:fitness4all/screen/home/settings/setting_row.dart';
import 'package:fitness4all/screen/home/settings/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  String photoURL = "assets/img/default_profile.png"; // Default profile picture

  @override
  void initState() {
    super.initState();
    loadProfileImage();
  }

  void loadProfileImage() {
    setState(() {
      if (user?.photoURL != null && user!.photoURL!.isNotEmpty) {
        photoURL = user!.photoURL!;
      }
    });
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.secondary,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/img/back.png",
            width: 18,
            height: 18,
          ),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          // Profile Section
          SettingRow(
            title: "Profile",
            icon: photoURL,
            isIconCircle: true,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          SettingRow(
            title: "Language options",
            icon: "assets/img/language.png",
            value: "Eng",
            onPressed: () {},
          ),
          SettingRow(
            title: "Health Data",
            icon: "assets/img/data.png",
            value: "",
            onPressed: () {},
          ),
          SettingRow(
            title: "Notification",
            icon: "assets/img/notification.png",
            value: "On",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
              );
            },
          ),
          SettingRow(
            title: "Meals Logger",
            icon: "assets/img/Meal_logger.png",
            value: "",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MealsScreen()),
              );
            },
          ),
          SettingRow(
            title: "Refer a Friend",
            icon: "assets/img/share.png",
            value: "",
            onPressed: () {},
          ),
          SettingRow(
            title: "Feedback",
            icon: "assets/img/feedback.png",
            value: "",
            onPressed: () {},
          ),
          SettingRow(
            title: "Rate Us",
            icon: "assets/img/rating.png",
            value: "",
            onPressed: () {},
          ),
          SettingRow(
            title: "Reminder",
            icon: "assets/img/reminder.png",
            value: "",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReminderScreen()),
              );
            },
          ),

          // Dark Mode Toggle
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return SettingRow(
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
              );
            },
          ),

          // Logout Button
          SettingRow(
            title: "Log Out",
            icon: "assets/img/logout.png",
            value: "",
            onPressed: logout,
          ),
        ],
      ),
    );
  }
}


