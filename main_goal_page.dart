import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
// goals landing page
//nav bar
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeLandingPage(),
    );
  }
}

class HomeLandingPage extends StatelessWidget {
  const HomeLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness App'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Let's achieve your fitness goals today!",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                buildFeatureButton(
                  context,
                  "Set Daily, Weekly, Monthly Goals",
                  Icons.flag,
                  Colors.orange,
                  const GoalSettingPage(),
                ),
                buildFeatureButton(
                  context,
                  "Specify Weight, Sleep, Calorie Goals",
                  Icons.fitness_center,
                  Colors.red,
                  const SpecificGoalSettingPage(),
                ),
                buildFeatureButton(
                  context,
                  "Update Goals",
                  Icons.edit,
                  Colors.green,
                  const UpdateGoalsPage(),
                ),
                buildFeatureButton(
                  context,
                  "Receive Reminders",
                  Icons.notifications,
                  Colors.purple,
                  const RemindersPage(),
                ),
                buildFeatureButton(
                  context,
                  "View Goal Progress Summary",
                  Icons.bar_chart,
                  Colors.teal,
                  const ProgressSummaryPage(),
                ),
                buildFeatureButton(
                  context,
                  "Set Time-Based Challenges",
                  Icons.timer,
                  Colors.blue,
                  const TimeBasedChallengesPage(),
                ),
                buildFeatureButton(
                  context,
                  "Share Goals with Friends",
                  Icons.share,
                  Colors.pink,
                  const ShareGoalsPage(),
                ),
                buildFeatureButton(
                  context,
                  "Receive Tips and Strategies",
                  Icons.lightbulb,
                  Colors.amber,
                  const TipsStrategiesPage(),
                ),
                buildFeatureButton(
                  context,
                  "Sync with Wearable Devices",
                  Icons.watch,
                  Colors.indigo,
                  const SyncWearablePage(),
                ),
                buildFeatureButton(
                  context,
                  "Get Milestone Notifications",
                  Icons.celebration,
                  Colors.cyan,
                  const MilestoneNotificationsPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFeatureButton(BuildContext context, String title, IconData icon, Color color, Widget page) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

// Feature Pages
class GoalSettingPage extends StatelessWidget {
  const GoalSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Daily, Weekly, Monthly Goals")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildGoalOption(context, "Set goal for today", Icons.today, Colors.orange),
            buildGoalOption(context, "Set goal for this week", Icons.calendar_view_week, Colors.green),
            buildGoalOption(context, "Set goal for this month", Icons.calendar_today, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget buildGoalOption(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$title clicked!")),
          );
        },
      ),
    );
  }
}

class SpecificGoalSettingPage extends StatelessWidget {
  const SpecificGoalSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Specify Weight, Sleep, Calorie Goals")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildGoalOption(context, "Set Weight Goal", Icons.monitor_weight, Colors.red),
            buildGoalOption(context, "Set Sleep Goal", Icons.bedtime, Colors.blue),
            buildGoalOption(context, "Set Calorie Goal", Icons.local_fire_department, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget buildGoalOption(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$title clicked!")),
          );
        },
      ),
    );
  }
}

class UpdateGoalsPage extends StatelessWidget {
  const UpdateGoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Goals")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildGoalOption(context, "Update Daily Goal", Icons.today, Colors.orange),
            buildGoalOption(context, "Update Weekly Goal", Icons.calendar_view_week, Colors.green),
            buildGoalOption(context, "Update Monthly Goal", Icons.calendar_today, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget buildGoalOption(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$title clicked!")),
          );
        },
      ),
    );
  }
}

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Receive Reminders")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildGoalOption(context, "Set Daily Reminder", Icons.today, Colors.orange),
            buildGoalOption(context, "Set Weekly Reminder", Icons.calendar_view_week, Colors.green),
            buildGoalOption(context, "Set Monthly Reminder", Icons.calendar_today, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget buildGoalOption(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$title clicked!")),
          );
        },
      ),
    );
  }
}

class ProgressSummaryPage extends StatelessWidget {
  const ProgressSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View Goal Progress Summary")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildGoalOption(context, "View Daily Progress", Icons.today, Colors.orange),
            buildGoalOption(context, "View Weekly Progress", Icons.calendar_view_week, Colors.green),
            buildGoalOption(context, "View Monthly Progress", Icons.calendar_today, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget buildGoalOption(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$title clicked!")),
          );
        },
      ),
    );
  }
}

class TimeBasedChallengesPage extends StatelessWidget {
  const TimeBasedChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Time-Based Challenges")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildGoalOption(context, "Set 7-Day Challenge", Icons.timer, Colors.orange),
            buildGoalOption(context, "Set 30-Day Challenge", Icons.timer_10, Colors.green),
            buildGoalOption(context, "Set 90-Day Challenge", Icons.timer_3, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget buildGoalOption(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$title clicked!")),
          );
        },
      ),
    );
  }
}

class ShareGoalsPage extends StatelessWidget {
  const ShareGoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Share Goals with Friends")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildGoalOption(context, "Share Daily Goals", Icons.today, Colors.orange),
            buildGoalOption(context, "Share Weekly Goals", Icons.calendar_view_week, Colors.green),
            buildGoalOption(context, "Share Monthly Goals", Icons.calendar_today, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget buildGoalOption(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$title clicked!")),
          );
        },
      ),
    );
  }
}

class TipsStrategiesPage extends StatelessWidget {
  const TipsStrategiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Receive Tips and Strategies")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildGoalOption(context, "Tips for Weight Loss", Icons.monitor_weight, Colors.red),
            buildGoalOption(context, "Tips for Better Sleep", Icons.bedtime, Colors.blue),
            buildGoalOption(context, "Tips for Calorie Control", Icons.local_fire_department, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget buildGoalOption(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$title clicked!")),
          );
        },
      ),
    );
  }
}

class SyncWearablePage extends StatelessWidget {
  const SyncWearablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sync with Wearable Devices")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildGoalOption(context, "Sync with Smartwatch", Icons.watch, Colors.indigo),
            buildGoalOption(context, "Sync with Fitness Tracker", Icons.fitness_center, Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget buildGoalOption(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$title clicked!")),
          );
        },
      ),
    );
  }
}

class MilestoneNotificationsPage extends StatelessWidget {
  const MilestoneNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Get Milestone Notifications")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildGoalOption(context, "Daily Milestone", Icons.today, Colors.orange),
            buildGoalOption(context, "Weekly Milestone", Icons.calendar_view_week, Colors.green),
            buildGoalOption(context, "Monthly Milestone", Icons.calendar_today, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget buildGoalOption(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$title clicked!")),
          );
        },
      ),
    );
  }
}